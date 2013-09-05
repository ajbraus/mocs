class CommitmentsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @post = Post.find(params[:post_id])
    @commitment = current_user.commitments.new

    if current_user.stripe_customer_id.present? 
      @stripe_customer = Stripe::Customer.retrieve(current_user.stripe_customer_id)
    end
  end

  def create
    @post = Post.find(params[:commitment][:commitment_id])
    @commitment = current_user.commitments.create!(commitment_id: @post.id)
    
    @amount = @post.price

    if @post.price == 0
      @commitment.paid = true
      @commitment.save
    else
      @amount = @post.price

      if current_user.stripe_customer_id.blank?
        customer = Stripe::Customer.create(
          :email => 'example@stripe.com',
          :card  => params[:stripeToken]
        )
        current_user.stripe_customer_id = customer.id
        current_user.save
      end

      charge = Stripe::Charge.create(
        :customer    => current_user.stripe_customer_id,
        :amount      => @amount,
        :description => "MocsforDocs - #{@post.title} - #{@post.user.name}",
        :currency    => 'usd'
      )
      @commitment.paid = charge.paid
      @commitment.save
    end
    
    Notifier.delay.payment_receipt(current_user, @post, @amount, @commitment)
    Notifier.delay.new_joiner(@post.user, current_user, @post)

    @post.last_touched = Time.now
    @post.save
    @post.create_activity :commit, owner: current_user

    respond_to do |format|
      format.html { redirect_to @post, notice: "Successfully Joined Project" }
      format.js
    end
  end

  def destroy
    commitment = Commitment.find(params[:id])
    post = Post.find(commitment.commitment_id)
    current_user.reneg!(commitment)
    respond_to do |format|
      format.html { redirect_to post }
      format.js
    end
  end

  def increment_progress
    commitment = Commitment.find(params[:id])
    post = Post.find(commitment.commitment_id)
    commitment.progress += 1
    commitment.save
    if commitment.progress >= 5
      post.create_activity :complete, owner: current_user
    end
    respond_to do |format|
      format.html { redirect_to post }
      format.js
    end
  end

  def decrement_progress
    commitment = Commitment.find(params[:id])
    post = Post.find(commitment.commitment_id)
    commitment.progress -= 1
    commitment.save
    respond_to do |format|
      format.html { redirect_to post }
      format.js
    end
  end
end