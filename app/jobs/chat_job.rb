class ChatJob < ApplicationJob
  queue_as :default

  def perform(application_id, chat_params)
      #create chat here
      @application = Application.find(application_id)
      @application.chats.create!(JSON.parse(chat_params))      
  end
end
