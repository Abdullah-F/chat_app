require 'rails_helper'

RSpec.describe 'messages', type: :request do
  describe 'POST messages#create' do
    let(:topic) { create(:subject) }
    let(:chat) { create(:chat, order: 1, subject: topic) }
    it 'creates a chat' do
      post "/subjects/#{topic.token}/chats/#{chat.order}/messages",
        :params => { :body => "a message body" }
      expect(response).to have_http_status(:ok)
      expect(json_response).to eq(1)
    end
  end
end
