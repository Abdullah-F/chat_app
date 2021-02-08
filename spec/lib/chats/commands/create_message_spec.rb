require 'rails_helper'

RSpec.describe Chats::Commands::CreateMessage do
  describe '#execute' do
    context 'when chat is not found' do
      it 'raises active record error' do
        expect do
          described_class.new(chat_order: 7).execute
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when params are invalid' do
      let(:chat){ create(:chat, subject: create(:subject)) }
      it 'raises active_record error' do
        expect do
          described_class.new(
            'chat_order'=> chat.order,
            'subject_token'=> chat.subject_token,
            'body'=> "message body",
          ).execute
        end.to raise_error(ActiveRecord::NotNullViolation)
      end
    end

    context 'when chat is found' do
      let(:chat){ create(:chat, subject: create(:subject)) }
      it 'creates a message' do
        expect do
          described_class.new(
            'chat_order'=> chat.order,
            'subject_token'=> chat.subject_token,
            'order'=> 1,
            'body'=> "message body",
          ).execute
        end.to change(Message, :count).by(1)
      end
    end
  end
end
