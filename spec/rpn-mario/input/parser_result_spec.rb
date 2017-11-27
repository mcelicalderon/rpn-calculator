require 'spec_helper'

RSpec.describe RPNMario::Input::ParserResult do
  context 'when the result has an error message' do
    subject { described_class.new(['54.', '.'], 'Invalid operands or numbers: 54., .') }

    it { is_expected.not_to be_valid }

    describe '#error' do
      it 'returns an error message' do
        expect(subject.error).to eq('Invalid operands or numbers: 54., .')
      end
    end

    describe '#elements' do
      it 'returns the original elements' do
        expect(subject.elements).to eq(['54.', '.'])
      end
    end
  end

  context 'when the result has no error' do
    subject { described_class.new(['1', '4', '+']) }

    it { is_expected.to be_valid }

    describe '#error' do
      it 'returns nil' do
        expect(subject.error).to be_nil
      end
    end

    describe '#elements' do
      it 'returns the original elements' do
        expect(subject.elements).to eq(['1', '4', '+'])
      end
    end
  end
end
