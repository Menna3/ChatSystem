require 'rails_helper'

RSpec.describe Message, type: :model do
  # Association test
  # ensure an item record belongs to a single todo record
  it { should belong_to(:chat) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:message_number) }
  it { should validate_presence_of(:message_body) }
end
