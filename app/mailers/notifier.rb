class Notifier < ActionMailer::Base
  include UsersHelper
  include ActionView::Helpers::AssetTagHelper  
  layout 'email' # use email.(html|text).erb as the layout for emails
  default from: "MocsforDocs.org Team@mocsfordocs.org"


  def request_confirmation(user)
    @user = user
    mail to: "team@mocsfordocs.org", subject: "New User to Confirm or Reject"
  end

  def welcome(user)
    @user = user
    mail to: @user.email, subject: "Welcome to MocsForDocs"
  end

  def new_moc(moc)
    @moc = moc
    mail to: "ajbraus@gmail.com, andrewscottconnely@gmail.com, tflood131@gmail.com", subject: "Woot! New MOC by #{@moc.user.name} - #{@moc.title}"
  end

  def send_message(message)
    @message = message
    @receiver = @message.receiver
    @sender = @message.sender
    mail to: @receiver.email, subject: "MOC Message from #{@sender.first_name}"
  end

  def moc_update(moc, user)
    @user = user
    @moc = moc
    mail bcc: @user.email, subject: "MOC Update: #{@moc.title}"
  end

  def missing_bank_info(user)
    @user = user
    mail to:"tflood131@gmail.com, ajbraus@gmail.com, andrewscottconnely@gmail.com", subject: "Transaction Failed - Missing bank account info for #{@user.name}"
  end

  def payout_receipt(user, owed_posts, total, payout)
    @user = user
    @owed_posts = owed_posts
    @total = total
    @payout = payout
    mail to: @user.email, subject: "Payment received from MocsforDocs"
  end

  def payment_receipt(user, moc, paid, commitment)
    @user = user
    @moc = moc
    @paid = paid
    @commitment = commitment
    mail to: @user.email, subject: "Receipt for Joining #{@moc.title}"
  end
end

