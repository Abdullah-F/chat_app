require 'rails_helper'

RSpec.describe Chats::Commands::SimpleFactory do
  describe '.create_command' do
    context 'when create_chat command is given' do
      it 'returns create_chat command' do
        command = described_class.create_command({
          'command' => 'create_chat', 'payload' => {}
        })
        expect(command).to be_a(Chats::Commands::CreateChat)
      end
    end
  end
end
