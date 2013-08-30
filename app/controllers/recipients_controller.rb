class RecipientsController < ApplicationController
  def new
  end

  def create
    # Create a Recipient
    recipient = Stripe::Recipient.create(
      :name => current_user.name,
      :type => "individual",
      :email => current_user.email,
      :bank_account => params[:stripeBankToken]
    )

    current_user.stripe_recipient_id = recipient.id
    current_user.stripe_verified = recipient.verified
    current_user.save

    respond_to do |format|
      format.html { redirect_to user_posts_path, notice: "Successfully Added Bank Account Information. You May Now Accept Payments." }
      format.js
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
