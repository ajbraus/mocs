class Notifier < ActionMailer::Base
  include UsersHelper
  include ActionView::Helpers::AssetTagHelper  
  layout 'email' # use email.(html|text).erb as the layout for emails
  default from: "MocsforDocs.org MocsForDocs@gmail.com"

  def welcome(user)
    @user = user

    mail to: @user.email, subject: "Welcome to MocsForDocs"
  end

  def new_moc(moc)
    @moc = moc
    mail to: "ajbraus@gmail.com, andrewscottconnely@gmail.com", subject: "Woot! New MOC by #{@moc.user.name} - #{@moc.title}"
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
end

