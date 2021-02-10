require 'rails_helper'

RSpec.describe Chats::Commands::SimpleFactory do
  describe '.create_command' do
    context 'when create_chat command is given' do
      it 'returns create_chat command' do
        expect_command_to_be_a(:create_chat)
      end
    end
    context 'when destroy_chat command is given' do
      it 'returns destroy_chat command' do
        expect_command_to_be_a(:destroy_chat)
      end
    end
    context 'when create_message command is given' do
      it 'returns create_message command' do
        expect_command_to_be_a(:create_message)
      end
    end

    context 'when destroy_message command is given' do
      it 'returns destroy_message command' do
        expect_command_to_be_a(:destroy_message)
      end
    end
    context 'when update_message command is given' do
      it 'returns update_message command' do
        expect_command_to_be_a(:update_message)
      end
    end

    def expect_command_to_be_a(command_name) # can be done better with rspec custom matchers.
      command = described_class.create_command({
        command: command_name.to_s, payload: {}
      })
      expect(command).to be_a(Chats::Commands.const_get(command_name.to_s.camelize))
    end
  end
end
