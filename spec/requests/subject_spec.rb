require 'rails_helper'

RSpec.describe 'subjects', type: :request do
  describe 'POST subjects#create' do
    it 'creates a chat subject' do
      expect do
        post '/subjects', :params => { :name => "subject" }, :headers => { "ACCEPT" => "application/json" }
      end.to change(Subject, :count).by(1)
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body).keys).to contain_exactly('name', 'token')
    end
  end
end
