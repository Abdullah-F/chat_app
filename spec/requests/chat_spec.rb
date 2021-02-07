require 'rails_helper'

RSpec.describe 'chats', type: :request do
  describe 'POST chats#create' do
    let(:topic) { create(:subject) }
    it 'creates a chat' do
      post "/subjects/#{topic.token}/chats"
      expect(response).to have_http_status(:ok)
      expect(json_response).to eq(1)
    end
  end

  describe 'DELETE chats#destroy' do
    let(:topic) { create(:subject) }
    let(:chat) { create(:chat, subject: topic, order: 1) }
    it 'creates a chat' do
      delete "/subjects/#{topic.token}/chats/#{chat.order}"
      expect(response).to have_http_status(:ok)
    end
  end
end
