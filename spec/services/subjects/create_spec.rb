require 'rails_helper'

RSpec.describe Subjects::Create, type: :service do
  describe '#execute' do
    it 'creates a new subject' do
      expect(Subject).to receive(:create!) { build_stubbed(:subject) }
      result = described_class.execute(name: "subject")
      expect(result).to be_success
      expect(result.subject).to be_present
    end

    context 'when name is not passed' do
      it 'fails' do
        expect(Subject).to receive(:create!)
          .and_raise(ActiveRecord::NotNullViolation)
        result = described_class.execute({})
        expect(result).not_to be_success
        expect(result.error).to be_present
      end
    end
  end
end
