class ChatMessagesController < ApplicationController
  include Response
  include ExceptionHandler
  before_action :set_application
  before_action :set_application_chat
  before_action :set_chat_message, only: [:show, :update, :destroy]

  # GET /chats/:chat_number/messages
  def index
    json_response(@chat.messages)
  end

  # GET /chats/:chat_number/messages/:message_number
  def show
    json_response(@message)
  end

  # POST applications/:token/chats/:chat_number/messages
  def create
    MessageJob.perform_later @chat.id, message_params.to_json 
    @message = @chat.messages.count == 0? 1: @chat.messages.last.message_number + 1
    json_response(@message, :created)
  end

  # PUT /chats/:chat_number/messages/:message_number
  def update
    @message.update(message_params)
    head :no_content
  end

  # DELETE /chats/:chat_number/messages/:message_number
  def destroy
    @message.destroy(params[:message_number])
    head :no_content
  end
    
  # GET /search?q=msg
  def search
    @messages = params[:query].nil? ? [] : ChatMessage.searchES(params[:chat_id], params[:query]).records
    json_response(@messages)
  end

  private

  def message_params
    params.permit(:message_body)
  end

  def set_application
    @application = Application.where(token: params[:token]).take
  end
    
  def set_application_chat
    @chat = @application.chats.where!(chat_number: params[:chat_number]).take if @application
  end

  def set_chat_message
    @message = @chat.messages.where!(message_number: params[:message_number]) if @chat
  end
end
