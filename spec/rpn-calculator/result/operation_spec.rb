require 'spec_helper'

RSpec.describe RPNCalculator::Result::Operation do
  context 'when the result has an error message' do
    subject { described_class.new([], ['1', '/', '2']) }

    it { is_expected.not_to be_valid }

    describe '#result' do
      it 'returns the passed result' do
        expect(subject.result).to eq([])
      end
    end

    describe '#error' do
      it 'returns an error message' do
        expect(subject.error).to eq('Invalid operation: 1 / 2')
      end
    end
  end

  context 'when the result has no error' do
    subject { described_class.new([16]) }

    it { is_expected.to be_valid }

    describe '#result' do
      it 'returns the passed result' do
        expect(subject.result).to eq([16])
      end
    end

    describe '#error' do
      it 'returns nil' do
        expect(subject.error).to be_nil
      end
    end
  end
end
