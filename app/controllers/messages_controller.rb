class MessagesController < ApplicationController
  def index
    @unread_messages = Message.where(receiver_id: current_user, is_read: false)
    @messages = Message.where(receiver_id: current_user).paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @messages }
    end


  end

  def create

    # TODO Add respond here
    respond_to do |format|
      format.js
    end
  end

  def show

  end

  def destroy
    
  end
end