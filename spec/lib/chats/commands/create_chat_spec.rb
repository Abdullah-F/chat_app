require 'rails_helper'

RSpec.describe Chats::Commands::CreateChat do
  describe '#execute' do
    let(:topic) { create(:subject, token: SecureRandom.uuid) }

    context 'when given valid params' do
      let(:params) do
        { subject_token: topic.token, order: 1}
      end
      it 'creates a chat' do
        expect {
          described_class.new(params).execute
        }.to change(Chat, :count).by(1)
      end
    end

    context 'when given invalid params' do
      let(:params) do
        { order: 1}
      end
      it 'raises ActiveRecord error' do
        expect {
          described_class.new(params).execute
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
