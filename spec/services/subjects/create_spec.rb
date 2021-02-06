require 'rails_helper'

RSpec.describe Subjects::Create, type: :service do
  describe '#execute' do
    subject { described_class.new(name: "subject") }
    it 'creates a new subject' do
      expect(Subject).to receive(:create!) { build_stubbed(:subject) }
      result = subject.execute
      expect(result).to be_success
      expect(result.subject).to be_present
    end

    context 'when name is not passed' do
      subject { described_class.new(name: "subject") }
      it 'fails' do
        expect(Subject).to receive(:create!).and_raise(ActiveRecord::NotNullViolation)
        result = subject.execute
        expect(result).not_to be_success
        expect(result.error).to be_present
      end
    end
  end
end
