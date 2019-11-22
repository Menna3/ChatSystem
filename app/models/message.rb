class Message < ApplicationRecord
  belongs_to :chat, touch: true

  after_initialize :add_message, if: :new_record?
    
  def add_message
      if chat.messages.count == 0
          self.message_number = 1
      else
         self.message_number = chat.messages.last.message_number + 1
      end
  end
    
  # validations
  validates_presence_of :message_number, :message_body
end
