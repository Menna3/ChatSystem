class MessageJob < ApplicationJob
  queue_as :high

  def perform(chat_id, message_params)
      @chat = Chat.find(chat_id)
      @chat.messages.create!(JSON.parse(message_params))      
  end
end
