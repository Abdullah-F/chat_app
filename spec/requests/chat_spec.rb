require 'rails_helper'

RSpec.describe 'chats', type: :request do
  let(:topic) { create(:subject) }
  describe 'POST chats#create' do
    it 'creates a chat' do
      post "/subjects/#{topic.token}/chats"
      expect(response).to have_http_status(:ok)
      expect(json_response).to eq(1)
    end
  end

  describe 'DELETE chats#destroy' do
    let(:chat) { create(:chat, subject: topic, order: 1) }
    it 'creates a chat' do
      delete "/subjects/#{topic.token}/chats/#{chat.order}"
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET subjects#show' do
    let(:chat) { create(:chat, subject: topic) }
    it 'returns a chat with its messages' do
      create_list(:message, 5, body: 'message body', chat: chat)
      get "/subjects/#{topic.token}/chats/#{chat.order}"
      expect(response).to have_http_status(:ok)
    end
  end
end
