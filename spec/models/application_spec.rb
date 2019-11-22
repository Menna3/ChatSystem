require 'rails_helper'

RSpec.describe Application, type: :model do
  # Association test
  # ensure Todo model has a 1:m relationship with the Item model
  it { should have_many(:chats).dependent(:destroy) }
  # Validation tests
  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:app_name) }
  it { should validate_presence_of(:token) }
  it { should validate_presence_of(:created_by) }
  it { should validate_presence_of(:chats_count) }
end
