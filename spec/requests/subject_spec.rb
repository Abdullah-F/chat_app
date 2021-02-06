require 'rails_helper'

RSpec.describe 'subjects', type: :request do
  describe 'POST subjects#create' do
    it 'creates a chat subject' do
      expect do
        post '/subjects', :params => { :name => "subject" }
      end.to change(Subject, :count).by(1)
      expect(response).to have_http_status(:created)
      expect(json_response.keys).to contain_exactly('name', 'token')
    end
  end
end
