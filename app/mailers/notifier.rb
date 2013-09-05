class Notifier < ActionMailer::Base
  include UsersHelper
  include ActionView::Helpers::AssetTagHelper  
  layout 'email' # use email.(html|text).erb as the layout for emails
  default from: "MocsforDocs.org Team@mocsfordocs.org"

  def internal_new_user(user)
    @user = user
    mail to: "team@mocsfordocs.org", subject: "New User to Confirm or Reject"
  end

  def confirmation_of_request(user)
    @user = user
    mail to: @user.email, subject: "Request Received for MocsforDocs.org Access"
  end

  def welcome(user)
    @user = user
    mail to: @user.email, subject: "Welcome to MocsForDocs"
  end

  def new_post(post)
    @post = post
    mail to: "team@mocsfordocs.org", subject: "Woot! New Project Created by #{@post.user.name} - #{@post.title}"
  end

  def send_message(message)
    @message = message
    @receiver = @message.receiver
    @sender = @message.sender
    mail to: @receiver.email, subject: "MOC Message from #{@sender.first_name}"
  end

  def post_update(post, user)
    @user = user
    @post = post
    mail bcc: @user.email, subject: "MOC Update: #{@post.title}"
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

  def payment_receipt(user, post, paid, commitment)
    @user = user
    @post = post
    @paid = paid
    @commitment = commitment
    mail to: @user.email, subject: "Receipt for Joining #{@post.title}"
  end

  def new_update(user, post, update)
    @user = user
    @post = post
    @update = update
    mail to: @user.email, subject: "Update on One of Your Projects - #{@post.title}"
  end

  def new_joiner(user, joiner, post)
    @user = user
    @joiner = joiner
    @post = post
    mail to: @user.email, subject: "New Joiner for Your MocsforDocs Project - #{@post.title}"
  end
end

