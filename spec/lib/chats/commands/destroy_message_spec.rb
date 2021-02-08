require 'rails_helper'

RSpec.describe Chats::Commands::DestroyMessage do
  describe '#execute' do
    context 'when chat is not found' do
      it 'raises active record error' do
        expect do
          described_class.new(chat_order: 7).execute
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when chat is found' do
      let(:message_order) { 1 }
      let(:params) do
        {
          'chat_order'=> chat.order,
          'subject_token'=> chat.subject_token,
          'order'=> message_order,
        }
      end
      let(:chat){ create(:chat, subject: create(:subject)) }
      before { create(:message, chat: chat, order: message_order) }

      it 'destroys a message' do
        expect do
          described_class.new(params).execute
        end.to change(Message, :count).by(-1)
      end
    end
  end
end
