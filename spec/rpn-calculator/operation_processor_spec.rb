require 'spec_helper'

RSpec.describe RPNCalculator::OperationProcessor do
  let(:input_validator)  { instance_double(RPNCalculator::Input::Validator) }
  let(:input_parser)     { instance_double(RPNCalculator::Input::Parser) }
  let(:allowed_operands) { ['+', '-', '/', '*'] }
  let(:validator_result) { double(:validator_result, valid?: true) }
  let(:parser_result)    { double(:parser_result, valid?: true) }

  describe '#process' do
    subject do
      described_class.new(allowed_operands, input_validator, input_parser)
    end

    before do
      allow(input_validator).to receive(:validate).and_return(validator_result)
      allow(input_parser).to    receive(:parse).and_return(parser_result)
    end

    context 'when input is invalid' do
      let(:validator_result) { double(:validator_result, valid?: false, error: 'Invalid input') }

      it 'returns an invalid processor result' do
        processor_result = subject.process('some invalid input')
        expect(processor_result).not_to be_valid
      end

      it 'returns a processor result with an error message' do
        processor_result = subject.process('some invalid input')
        expect(processor_result.error).to eq('Invalid input')
      end
    end

    context 'when input is valid and parsing fails' do
      let(:validator_result) { double(:validator_result, valid?: true) }
      let(:parser_result)    { double(:parser_result, valid?: false, error: 'Invalid input after parsing') }

      it 'returns an invalid processor result' do
        processor_result = subject.process('invalid even after char validation')
        expect(processor_result).not_to be_valid
      end

      it 'returns a processor result with an error message' do
        processor_result = subject.process('some invalid input')
        expect(processor_result.error).to eq('Invalid input after parsing')
      end
    end

    context 'when input and parsing are valid' do
    end
  end
end
