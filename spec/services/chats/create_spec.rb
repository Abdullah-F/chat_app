require 'rails_helper'

RSpec.describe Chats::Create, type: :service do
  describe '#execute' do
    context 'when not prevousily set in redis' do
      subject { described_class.new(subject_token: topic.token) }
      let(:new_chats_count) { 6 }
      let(:topic) { build_stubbed(:subject, chats_count: 5) }

      it 'returns 1 as the order of the chat' do
        expect(Subject).to receive(:find_by).and_return(topic)
        expect(ChatWorker).to receive(:perform_async).with({
          command: :create_chat,
          payload: { order: new_chats_count, subject_token: topic.token }
        })
        result = subject.execute
        expect(result).to be_success
        expect(RedisClient.get(topic.token).to_i).to eq(new_chats_count)
        expect(result.order).to eq(new_chats_count)
      end
    end

    context 'when order is already set in redis' do
      subject { described_class.new(subject_token: token) }
      let(:token) { "token" }
      let(:new_chats_count) { 2 }

      it 'increments the order directly' do
        RedisClient.set(token, 1)
        expect(Subject).not_to receive(:find_by)
        expect(ChatWorker).to receive(:perform_async).with({
          command: :create_chat,
          payload: { order: new_chats_count, subject_token: token }
        })
        result = subject.execute
        expect(result).to be_success
        expect(RedisClient.get(token).to_i).to eq(new_chats_count)
        expect(result.order).to eq(new_chats_count)
      end
    end
  end
end
