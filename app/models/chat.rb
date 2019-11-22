class Chat < ApplicationRecord
  belongs_to :application
  has_many :messages, dependent: :destroy, class_name: "::ChatMessage"
    
  after_initialize :add_chat, if: :new_record?
    
  def add_chat
      #if the first chat for the application, then chat_number == 1
      if application.chats.count == 0
          self.chat_number = 1
      else
         self.chat_number = application.chats.last.chat_number + 1
      end
      self.messages_count = '0'
  end

  # validations
  validates_presence_of :chat_number, :messages_count, :chat_name
end
