class Application < ApplicationRecord
  # model association
  has_many :chats, dependent: :destroy

  after_initialize :add_application, if: :new_record?
    
  def add_application
      self.chats_count = '0'
      self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
    
  # validations
  validates_presence_of :token, :app_name, :chats_count, :created_by
    
  
end
