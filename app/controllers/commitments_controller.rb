class CommitmentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @post = Post.find(params[:commitment][:commitment_id])
    current_user.commit!(@post)
    @post.last_touched = Time.now
    @post.save
    @post.create_activity :commit, owner: current_user

    # marketplace = Balanced::Marketplace.my_marketplace
    # # user represents a user in our database who wants to rent a bicycle
    # # buyer is a Balanced::Customer object that knows about payment information for user
    # # or guest who wants to rent a bicycle
    # buyer, user = nil, nil
    # if user_signed_in? # logic to handle guest/not signed in users
    #   buyer = current_user.balanced_customer
    # else
    #   buyer = User.create_balanced_customer(
    #     :name  => params[:"guest-name"],
    #     :email => params[:"guest-email_address"]
    #     )
    # end
    # listing = Listing.find(params[:listing_id])
    # listing.rent(:renter => buyer, :card_uri => params[:card_uri])
    # render :confirmation

    respond_to do |format|

      format.html { redirect_to @post }
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