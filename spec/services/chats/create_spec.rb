require 'rails_helper'

RSpec.describe Chats::Create, type: :service do
  describe '#execute' do
    context 'when not prevousily set in redis' do
      let(:new_chats_count) { 6 }
      let(:topic) do
        create(:subject, chats_count: 5, token: SecureRandom.uuid)
      end

      it 'returns 1 as the order of the chat' do
        expect(ChatWorker).to receive(:perform_async).with({
          command: :create_chat,
          payload: { order: new_chats_count, subject_token: topic.token }
        })
        result = described_class.execute(subject_token: topic.token)
        expect(result).to be_success
        expect(RedisClient.get(topic.token).to_i).to eq(new_chats_count)
        expect(result.order).to eq(new_chats_count)
      end
    end

    context 'when order is already set in redis' do
      let(:token) { "token" }
      let(:new_chats_count) { 2 }

      it 'increments the order directly' do
        RedisClient.set(token, 1)
        expect(Subject).not_to receive(:find_by)
        expect(ChatWorker).to receive(:perform_async).with({
          command: :create_chat,
          payload: { order: new_chats_count, subject_token: token }
        })
        result = described_class.execute(subject_token: token)
        expect(result).to be_success
        expect(RedisClient.get(token).to_i).to eq(new_chats_count)
        expect(result.order).to eq(new_chats_count)
      end
    end
  end
end
