require 'rails_helper'

RSpec.describe Chats::Destroy, type: :service do
  describe '#execute' do
    let(:payload) do
      {
        subject_token: 'subject_token',
        order: 'chat_order',
      }
    end

    it 'destroys the chat asynchronously' do
      expect(ChatWorker).to receive(:perform_async).with(
        command: :destroy_chat,
        payload: payload
      )
      result = described_class.execute(payload)
    end
  end
end
