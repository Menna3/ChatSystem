class ApplicationJobs < ApplicationJob
  def initialize chat_counts
  queue_as :high
  self.queue_adapter = :sidekiq  
  def perform countChats
     p 'yarab'
#    self.chats_count = chats.count
#    self.save
  end
end