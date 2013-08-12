class RegistrationsController < Devise::RegistrationsController

  def create
    @user = User.create(params[:user])
    organization = Organization.find_by_name(params[:organization])
    @user.organizations << organization

    if @user.save
      if @user.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(@user_name, @user)
        respond_with @user, :location => after_sign_up_path_for(@user)
      else
        set_flash_message :notice, :"signed_up_but_#{@user.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with @user, :location => after_inactive_sign_up_path_for(@user)
      end
    else
      clean_up_passwords @user
      respond_with @user
    end
  end

  protected

  def after_sign_up_path_for(resource)
    '/'
  end
end