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
    context 'when destroy_chat command is given' do
      it 'returns destroy_chat command' do
        command = described_class.create_command({
          'command' => 'destroy_chat', 'payload' => {}
        })
        expect(command).to be_a(Chats::Commands::DestroyChat)
      end
    end
    context 'when create_message command is given' do
      it 'returns create_message command' do
        command = described_class.create_command({
          'command' => 'create_message', 'payload' => {}
        })
        expect(command).to be_a(Chats::Commands::CreateMessage)
      end
    end

    context 'when destroy_message command is given' do
      it 'returns destroy_message command' do
        command = described_class.create_command({
          'command' => 'destroy_message', 'payload' => {}
        })
        expect(command).to be_a(Chats::Commands::DestroyMessage)
      end
    end
    context 'when update_message command is given' do
      it 'returns update_message command' do
        command = described_class.create_command({
          'command' => 'update_message', 'payload' => {}
        })
        expect(command).to be_a(Chats::Commands::UpdateMessage)
      end
    end
  end
end
