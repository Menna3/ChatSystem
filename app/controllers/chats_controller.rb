class ChatsController < ApplicationController
  include Response
  include ExceptionHandler
  before_action :set_application
  before_action :set_application_chat, only: [:show, :update, :destroy]

  # GET /applications/:application_id/chats
  def index
    json_response(@application.chats)
  end

  # GET /applications/:token/chats/:chat_number
  def show
    json_response(@chat)
  end

  # POST /applications/:token/chats
  def create 
    ChatJob.perform_later @application.id, chat_params.to_json
    @chat = @application.chats.last.chat_number + 1
    json_response(@chat, :created)
  end

  # PUT /applications/:token/chats/:chat_number
  def update
    @chat.update(chat_params)
    head :no_content
  end

  # DELETE /applications/:token/chats/:chat_number
  def destroy
    @chat.destroy
    head :no_content
  end

  private

  def chat_params
    params.permit(:chat_name)
  end

  def set_application
    @application = Application.where(token: params[:token]).take
  end

  def set_application_chat
    @chat = @application.chats.where!(chat_number: params[:chat_number]).take if @application
  end
end
