require 'spec_helper'

RSpec.describe RPNCalculator::Operation::Addition do
  context 'when the operation is invalid' do
    subject { described_class.new(['1']) }

    describe '#result' do
      it 'returns an invalid operation result' do
        expect(subject.result).not_to be_valid
      end
    end
  end

  context 'when the operation has no error' do
    subject { described_class.new(['7', '3', '1.3']) }

    describe '#result' do
      it 'returns the sum of the operands' do
        expect(subject.result.result).to eq(11.3)
      end
    end
  end
end
