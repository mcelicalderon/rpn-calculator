require 'spec_helper'

RSpec.describe RPNCalculator::Operation::Multiplication do
  context 'when the operands are invalid' do
    let(:invalid_elements) { ['1'] }

    subject { described_class.new(invalid_elements) }

    describe '#result' do
      it 'returns an invalid operation result' do
        expect(subject.result).not_to be_valid
      end
    end

    describe '#.operate' do
      it 'returns an invalid operation result' do
        expect(described_class.operate(invalid_elements)).not_to be_valid
      end
    end
  end

  context 'when the operands are valid' do
    let(:valid_elements) { ['7', '3'] }

    subject { described_class.new(valid_elements) }

    describe '#result' do
      it 'returns the sum of the operands' do
        expect(subject.result.result).to eq(21.0)
      end
    end

    describe '#.operate' do
      it 'rreturns the sum of the operands' do
        expect(described_class.operate(valid_elements).result).to eq(21.0)
      end
    end
  end
end
