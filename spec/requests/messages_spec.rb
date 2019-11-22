require 'rails_helper'

RSpec.describe 'Messages API' do
  # Initialize the test data    
  let(:user) { create(:user) }
  let!(:application) { create(:application, created_by: user.id) }
  let!(:chats) { create(:chat, application_id: application.id) }
  let!(:messages) { create_list(:message, 20, chat_id: chat.id) }
  let(:application_id) { application.id }
  let(:chat_id) { chat.id }
  let(:id) { messages.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /todos/:todo_id/items
  describe 'GET /applications/:application_id/chats/:chat_id/messages' do
    before { get "/applications/#{application_id}/chats/#{chat_id}", params: {}, headers: headers }


    context 'when application exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all application chats' do
        expect(json.size).to eq(20)
      end
    end

    context 'when application does not exist' do
      let(:application_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Application/)
      end
    end
  end

  # Test suite for GET /applications/:application_id/chats/:id
  describe 'GET /applications/:application_id/chats/:id' do
    before { get "/applications/#{application_id}/chats/#{id}", params: {}, headers: headers }

    context 'when application item exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the chat' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when application item does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Chat/)
      end
    end
  end

  # Test suite for PUT /applications/:application_id/chats
  describe 'POST /applications/:application_id/chats' do
    let(:valid_attributes) { { chat_number: '1', messages_count: '3' } }

    context 'when request attributes are valid' do
      before { post "/applications/#{application_id}/chats", params: valid_attributes, headers: headers}

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/applications/#{application_id}/chats", params: {}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /applications/:application_id/chats/:id
  describe 'PUT /applications/:application_id/chats/:id' do
    let(:valid_attributes) { { chat_number: 'Mozart' } }

    before { put "/applications/#{application_id}/chats/#{id}", params: valid_attributes, headers: headers }

    context 'when item exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the chat' do
        updated_chat = Chat.find(id)
        expect(updated_chat.chat_number).to match(/Mozart/)
      end
    end

    context 'when the chat does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Chat/)
      end
    end
  end

  # Test suite for DELETE /todos/:id
  describe 'DELETE /applications/:id' do
    before { delete "/applications/#{application_id}/chats/#{id}" , params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end