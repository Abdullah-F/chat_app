require 'rails_helper'

RSpec.describe Chats::Commands::UpdateMessage do
  describe '#execute' do
    context 'when chat is not found' do
      it 'raises active record error' do
        expect do
          described_class.new(chat_order: 7).execute
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when chat is found' do
      let(:params) do
        {
          'chat_order'=> chat.order,
          'subject_token'=> chat.subject_token,
          'order'=> message.order,
          'body' => 'updated_body'
        }
      end
      let(:chat){ create(:chat, subject: create(:subject)) }
      let(:message) do
        create(:message, chat: chat, body: 'initial body')
      end

      it 'updates a message' do
        described_class.new(params).execute
        expect(message.reload.body).to eq(params['body'])
      end
    end
  end
end
