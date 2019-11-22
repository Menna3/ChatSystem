class CountJob < ApplicationJob
  queue_as :default

  def perform(*args)
      
    Application.all.each do |application|
      application.chats_count = application.chats.count
      application.save
    end
      
    Chat.all.each do |chat|
        chat.messages_count = chat.messages.count
        chat.save
    end
      
  end
end
