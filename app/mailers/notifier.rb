class Notifier < ActionMailer::Base
  include UsersHelper
  include ActionView::Helpers::AssetTagHelper  
  layout 'email' # use email.(html|text).erb as the layout for emails
  default from: "MocsForDocs Team MocsForDocs@gmail.com"

  def welcome(user)
    @user = user

    mail to: @user.email, subject: "Welcome to MocsForDocs"
  end

  def new_moc(moc)
    @moc = moc
    mail to: "ajbraus@gmail.com, andrewscottconnely@gmail.com", subject: "Woot! New MOC by #{@moc.user.name} - #{@moc.title}"
  end
end
