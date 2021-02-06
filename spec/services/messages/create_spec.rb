require 'rails_helper'

RSpec.describe Messages::Create, type: :service do
  describe '#execute' do
    context 'when not prevousily set in redis' do
      let(:new_messages_count) { 6 }
      let(:chat) { build_stubbed(:chat, subject_token: "token", messages_count: 5) }
      let(:redis_key) { "#{chat.subject_token}:#{chat.order}" }

      it 'fetchs the order from the database' do
        expect(Chat).to receive(:find).and_return(chat)
        expect(ChatWorker).to receive(:perform_async).with({
          command: :create_message,
          payload: { order: new_messages_count, chat_order: chat.order,  subject_token: chat.subject_token }
        })
        result = described_class.execute(subject_token: chat.subject_token, chat_order: chat.order)
        expect(result).to be_success
        expect(RedisClient.get(redis_key).to_i).to eq(new_messages_count)
        expect(result.order).to eq(new_messages_count)
      end
    end

    context 'when order is already set in redis' do
      let(:token) { "token" }
      let(:chat_order) { 1 }
      let(:new_messages_count) { 2 }
      let(:redis_key) { "#{token}:#{chat_order}" }

      it 'increments the order directly' do
        RedisClient.set(redis_key, 1)
        expect(Chat).not_to receive(:find)
        expect(ChatWorker).to receive(:perform_async).with({
          command: :create_message,
          payload: { order: new_messages_count, chat_order: chat_order,  subject_token: token }
        })
        result = described_class.execute(subject_token: token, chat_order: chat_order)
        expect(result).to be_success
        expect(RedisClient.get(redis_key).to_i).to eq(new_messages_count)
        expect(result.order).to eq(new_messages_count)
      end
    end
  end
end
