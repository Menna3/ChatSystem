require 'rails_helper'

RSpec.describe 'Applications API', type: :request do
  # initialize test data 
  let(:user) { create(:user) }
  let!(:applications) { create_list(:application, 10, created_by: user.id) }
  let(:application_id) { applications.first.id }
  # authorize request
  let(:headers) { valid_headers }

  # Test suite for GET /applications
  describe 'GET /applications' do
    # make HTTP get request before each example
    before { get '/applications' , params: {}, headers: headers }

    it 'returns applications' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /applications/:id
  describe 'GET /applications/:id' do
    before { get "/applications/#{application_id}" , params: {}, headers: headers }

    context 'when request is valid' do
      before { post '/todos', params: valid_attributes, headers: headers }
    
      it 'returns the application' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(application_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { app_name: nil }.to_json }
      before { post '/applications', params: invalid_attributes, headers: headers }
        
      let(:application_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Application/)
      end
    end
  end

  # Test suite for POST /applications
  describe 'POST /applications' do
    # valid payload
    let(:valid_attributes) do
      # send json payload
      { token: 'asdf', app_name: 'App 1', chats_count: '3', created_by: user.id.to_s }.to_json
    end

    context 'when the request is valid' do
      before { post '/applications', params: valid_attributes, headers: headers  }

      it 'creates an application' do
        expect(json['app_name']).to eq('App 1')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/applications', params: { app_name: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  # Test suite for PUT /applications/:id
  describe 'PUT /applications/:id' do
    let(:valid_attributes) { { app_name: 'Shopping' } }

    context 'when the record exists' do
      before { put "/applications/#{application_id}", params: valid_attributes, headers: headers  }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /applications/:id
  describe 'DELETE /applications/:id' do
    before { delete "/applications/#{application_id}" , params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end