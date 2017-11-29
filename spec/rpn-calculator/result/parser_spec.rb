require 'spec_helper'

RSpec.describe RPNCalculator::Result::Parser do
  context 'when the result has an error message' do
    let(:parsed_input) { ['1', '5', '+', '.', '10', '*', '5.1.3'] }

    subject { described_class.new(parsed_input, ['.', '5.1.3']) }

    it { is_expected.not_to be_valid }

    describe '#error' do
      it 'returns an error message' do
        expect(subject.error).to eq('Invalid operators or numbers: ., 5.1.3')
      end
    end

    describe '#parsed_elements' do
      it 'returns the original elements' do
        expect(subject.parsed_elements).to eq(parsed_input)
      end
    end
  end

  context 'when the result has no error' do
    let(:parsed_input) { ['1', '5', '+', '10', '*'] }

    subject { described_class.new(parsed_input, []) }

    it { is_expected.to be_valid }

    describe '#error' do
      it 'returns nil' do
        expect(subject.error).to be_nil
      end
    end

    describe '#parsed_elements' do
      it 'returns the original elements' do
        expect(subject.parsed_elements).to eq(parsed_input)
      end
    end
  end
end
