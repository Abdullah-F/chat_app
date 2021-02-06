require 'rails_helper'

RSpec.describe 'chats', type: :request do
  describe 'POST chats#create' do
    let(:application) { create(:subject) }
    it 'creates a chat' do
      post "/subjects/#{application.token}/chats"
      expect(response).to have_http_status(:ok)
      expect(json_response).to eq(1)
    end
  end
end
