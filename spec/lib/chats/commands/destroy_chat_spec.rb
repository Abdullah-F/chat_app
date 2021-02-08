require 'rails_helper'

RSpec.describe Chats::Commands::DestroyChat do
  describe '#execute' do
    let(:topic) { create(:subject, token: SecureRandom.uuid) }

    context 'when given valid params' do
      let(:params) do
        { subject_token: topic.token, order: 1}
      end
      before { create(:chat, subject: topic, order: 1) }

      it 'destroys a chat' do
        expect {
          described_class.new(params).execute
        }.to change(Chat, :count).by(-1)
      end
    end

    context 'when given invalid params' do
      let(:params) do
        { order: 2, subject_token: "invalid" }
      end

      it 'raises ActiveRecord error' do
        expect {
          described_class.new(params).execute
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
