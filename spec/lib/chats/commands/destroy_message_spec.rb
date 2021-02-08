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
      let(:chat){ create(:chat, subject: create(:subject)) }

      it 'destroys a message' do
        message = create(:message, chat: chat)
        expect do
          described_class.new(
            'chat_order'=> chat.order,
            'subject_token'=> chat.subject_token,
            'order'=> message.order,
          ).execute
        end.to change(Message, :count).by(-1)
      end
    end
  end
end
