class OrganizationsController < ApplicationController
  before_filter :authenticate_user!
  
  def show
    @org = Organization.find(:id)
    if current_user.org_admin?(@org)

    else 
      redirect_to root_path, notice: "Oops, here you go!"
    end
  end
end