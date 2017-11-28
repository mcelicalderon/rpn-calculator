require 'spec_helper'

RSpec.describe RPNCalculator::Result::Validator do
  context 'when the result has an error message' do
    subject { described_class.new(['y', 'l']) }

    it { is_expected.not_to be_valid }

    describe '#error' do
      it 'returns an error message' do
        expect(subject.error).to eq('Invalid characters: y, l')
      end
    end
  end

  context 'when the result has no error' do
    subject { described_class.new([]) }

    it { is_expected.to be_valid }

    describe '#error' do
      it 'returns nil' do
        expect(subject.error).to be_nil
      end
    end
  end
end
