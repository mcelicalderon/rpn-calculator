require 'spec_helper'

RSpec.describe RPNCalculator::Operation::Multiplication do
  context 'when the operands are invalid' do
    subject { described_class.new(['1']) }

    describe '#result' do
      it 'returns an invalid operation result' do
        expect(subject.result).not_to be_valid
      end
    end
  end

  context 'when the operands are valid' do
    subject { described_class.new(['7', '3']) }

    describe '#result' do
      it 'returns the sum of the operands' do
        expect(subject.result.result).to eq(21.0)
      end
    end
  end
end
