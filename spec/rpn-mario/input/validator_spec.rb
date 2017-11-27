require 'spec_helper'

RSpec.describe RPNMario::Input::Validator do
  subject do
    described_class.new(/[^\d\s\+\-\/\*]/.freeze)
  end

  describe '#validate' do
    context 'when input is valid' do
      it 'returns a valid result object with no errors' do
        result = subject.validate('1 44 + 2 *')

        expect(result).to be_valid
        expect(result.error).to be_nil
      end
    end

    context 'when input is invalid' do
      it 'returns an invalid result object with errors' do
        result = subject.validate('1 44+ 2 j ** k')

        expect(result).not_to be_valid
        expect(result.error).to eq('Invalid characters: j, k')
      end
    end
  end
end
