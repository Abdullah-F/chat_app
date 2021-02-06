require 'rails_helper'

RSpec.describe 'subjects', type: :request do
  describe 'POST subjects#create' do
    it 'creates a chat subject' do
      expect do
        post '/subjects', :params => { :name => "subject" }
      end.to change(Subject, :count).by(1)
      expect(response).to have_http_status(:created)
      expect(json_response.keys).to contain_exactly(
        'name', 'token', 'chats_count', 'created_at', 'updated_at'
      )
    end

    context 'when the name is not sent' do
      it 'fails' do
        post '/subjects'
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response.keys).to contain_exactly('error')
      end
    end
  end
end
