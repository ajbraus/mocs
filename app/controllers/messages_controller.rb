class MessagesController < ApplicationController
  def index
    @messages = current_user.messages
    @sent_messages = current_user.sent_messages

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @messages }
    end
  end

  def create
    @message = Message.create(params[:message])
    @message.save

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @message = Message.find(params[:id])
    @message.is_read = true
    @message.save
    
    @receiver = @message.receiver

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message }
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Message successfully deleted" }
      format.json { head :no_content }
    end
  end
end