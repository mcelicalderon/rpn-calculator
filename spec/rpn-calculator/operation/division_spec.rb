require 'spec_helper'

RSpec.describe RPNCalculator::Operation::Division do
  context 'when the operands are invalid' do
    subject { described_class.new(['7', '2', '3']) }

    describe '#result' do
      it 'returns an invalid operation result' do
        expect(subject.result).not_to be_valid
      end
    end
  end

  context 'when the operands are valid' do
    subject { described_class.new(['8', '16']) }

    describe '#result' do
      it 'returns the sum of the operands' do
        expect(subject.result.result).to eq(0.5)
      end
    end
  end
end
