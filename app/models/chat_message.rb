require 'elasticsearch/model'

class ChatMessage < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks  
    
  belongs_to :chat

  after_initialize :add_message, if: :new_record?
    
  def add_message
      if chat.messages.count == 0
          self.message_number = 1
      else
         self.message_number = chat.messages.last.message_number + 1
      end
  end
    
  mappings dynamic: 'false' do
    indexes :message_body
    indexes :chat_id
  end
    
  def as_indexed_json(options = {})
      self.as_json(only: [:message_body, :chat_id])
  end
    
  def self.searchES(chat_id, body)
      __elasticsearch__.search({
        "query": {
            "bool": {
                "must": [
                    {
                        "query_string": {
                        "default_field": "message_body",
                        "query": body
                        }
                    },
                    {
                        "match": {
                        "chat_id": chat_id
                        }
                    }
                ]
            }
        }
      })
  end
    
    
  # validations
  validates_presence_of :message_number, :message_body
end

ChatMessage.__elasticsearch__.refresh_index! force: true
ChatMessage.import force: true
