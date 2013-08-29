class RecipientsController < ApplicationController
  def new
  end

  def create
    # Amount in cents
    @amount = params[:price]

    # Create a Recipient
    recipient = Stripe::Recipient.create(
      :name => "John Doe",
      :type => "individual",
      :email => "payee@example.com",
      :bank_account => params[:stripeToken]
    )

    current_user.stripe_recipient_id = recipient.id

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
