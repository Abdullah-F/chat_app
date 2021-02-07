require 'rails_helper'

RSpec.describe 'messages', type: :request do
  let(:topic) { create(:subject) }
  let(:chat) { create(:chat, order: 1, subject: topic) }
  let(:message) { create(:message, order: 1, chat: chat, body: "old_body") }

  describe 'POST messages#create' do
    it 'creates a chat' do
      post "/subjects/#{topic.token}/chats/#{chat.order}/messages",
        :params => { :body => "a message body" }
      expect(response).to have_http_status(:ok)
      expect(json_response).to eq(1)
    end
  end

  describe 'PUT messages#upate' do
    it 'updates a message' do
      put "/subjects/#{topic.token}/chats/#{chat.order}/messages/#{message.order}",
        :params => { :body => "new_body" }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'Delete messages#destroy' do
    it 'updates a message' do
      delete "/subjects/#{topic.token}/chats/#{chat.order}/messages/#{message.order}"
      expect(response).to have_http_status(:ok)
    end
  end
end
