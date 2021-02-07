require 'rails_helper'

RSpec.describe Messages::Destroy, type: :service do
  describe '#execute' do
    let(:payload) do
      {
        subject_token: 'subject_token',
        chat_order: 'chat_order',
        order: 'order',
      }
    end

    it 'destroys the message asynchronously' do
      expect(ChatWorker).to receive(:perform_async).with(
        command: :destroy_message,
        payload: payload
      )
      result = described_class.execute(payload)
    end
  end
end
