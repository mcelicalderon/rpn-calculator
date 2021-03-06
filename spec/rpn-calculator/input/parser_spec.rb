require 'spec_helper'

RSpec.describe RPNCalculator::Input::Parser do
  let(:allowed_operators) { ['+', '-', '/', '*'] }

  describe '#parse' do
    it 'splits operands and operators separated by whitespace' do
      parsed_result = described_class.new(allowed_operators).parse('12 4 + 5 -   3 * ')
      expect(parsed_result.result).to eq(['12', '4', '+', '5', '-', '3', '*'])
    end

    it 'splits operands and operators even if there is no whitespace between them' do
      parsed_result = described_class.new(allowed_operators).parse('12 4 +5 - 3 ** ')
      expect(parsed_result.result).to eq(['12', '4', '+', '5', '-', '3', '*', '*'])
    end

    it 'splits two operands separated by an operator and no whitespace correctly' do
      parsed_result = described_class.new(allowed_operators).parse('12 4*5 +5.5 - 3 ** ')
      expect(parsed_result.result).to eq(['12', '4', '*', '5', '+', '5.5', '-', '3', '*', '*'])
    end

    it 'takes period as a valid part of a number' do
      parsed_result = described_class.new(allowed_operators).parse('12 4 +5.5 - 3 ** ')
      expect(parsed_result.result).to eq(['12', '4', '+', '5.5', '-', '3', '*', '*'])
    end

    it 'fails if the input number is not valid' do
      parsed_result = described_class.new(allowed_operators).parse('12 4 +5.5. - 3 ** . ')

      expect(parsed_result).not_to be_valid
      expect(parsed_result.error).to eq('Invalid operators or numbers: 5.5., .')
      expect(parsed_result.result).to eq(['12', '4', '+', '5.5.', '-', '3', '*', '*', '.'])
    end
  end
end
