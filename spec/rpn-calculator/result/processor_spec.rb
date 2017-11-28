require 'spec_helper'

RSpec.describe RPNCalculator::Result::Processor do
  let(:error_string) { 'Validation, parsing or operation error' }

  context 'when the result has an error message' do
    subject { described_class.new([], error_string) }

    it { is_expected.not_to be_valid }

    describe '#error' do
      it 'returns an error message' do
        expect(subject.error).to eq('Validation, parsing or operation error')
      end
    end

    describe '#result' do
      it 'returns an empty array' do
        expect(subject.result).to be_empty
      end
    end
  end

  context 'when the result has no error' do
    subject { described_class.new(['6', '7']) }

    it { is_expected.to be_valid }

    describe '#error' do
      it 'returns nil' do
        expect(subject.error).to be_nil
      end
    end

    describe '#result' do
      it 'returns the result or incomplete operations as an array' do
        expect(subject.result).to eq(['6', '7'])
      end
    end
  end
end
