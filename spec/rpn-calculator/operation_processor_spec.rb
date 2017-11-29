require 'spec_helper'

RSpec.describe RPNCalculator::OperationProcessor do
  let(:input_validator)   { instance_double(RPNCalculator::Input::Validator) }
  let(:input_parser)      { instance_double(RPNCalculator::Input::Parser) }
  let(:validator_result)  { double(:validator_result, valid?: true) }
  let(:parser_result)     { double(:parser_result, valid?: true) }
  let(:operation_classes) do
    {
      '+' => RPNCalculator::Operation::Addition,
      '-' => RPNCalculator::Operation::Subtraction,
      '*' => RPNCalculator::Operation::Multiplication,
      '/' => RPNCalculator::Operation::Division
    }.freeze
  end

  describe '#process' do
    subject do
      described_class.new(operation_classes, input_validator, input_parser)
    end

    before do
      allow(input_validator).to receive(:validate).and_return(validator_result)
      allow(input_parser).to    receive(:parse).and_return(parser_result)
    end

    context 'when input is invalid' do
      let(:validator_result) { double(:validator_result, valid?: false, error: 'Invalid input') }

      it 'returns an invalid processor result' do
        processor_result = subject.process([], 'some invalid input')
        expect(processor_result).not_to be_valid
      end

      it 'returns a processor result with an error message' do
        processor_result = subject.process([], 'some invalid input')
        expect(processor_result.error).to eq('Invalid input')
      end
    end

    context 'when input is valid and parsing fails' do
      let(:validator_result) { double(:validator_result, valid?: true) }
      let(:parser_result)    { double(:parser_result, valid?: false, error: 'Invalid input after parsing') }

      it 'returns an invalid processor result' do
        processor_result = subject.process([], 'invalid even after char validation')
        expect(processor_result).not_to be_valid
      end

      it 'returns a processor result with an error message' do
        processor_result = subject.process([], 'some invalid input')
        expect(processor_result.error).to eq('Invalid input after parsing')
      end
    end

    context 'when input and parsing are valid' do
      context 'when operations are valid' do
        let(:valid_input) { '1 2 + 8 * 6 /' }

        it 'returns a valid operation result' do
          allow(parser_result).to receive(:parsed_elements).and_return(valid_input.split(' '))

          processor_result = subject.process([], valid_input)
          expect(processor_result).to be_valid
        end

        it 'returns a valid operation result with the correct operation value' do
          allow(parser_result).to receive(:parsed_elements).and_return(valid_input.split(' '))

          processor_result = subject.process([], valid_input)
          expect(processor_result.result).to eq([4.0])
        end

        it 'returns correct operation value plus remaining elements in the stack' do
          allow(parser_result).to receive(:parsed_elements).and_return((valid_input + ' 10').split(' '))
          processor_result = subject.process([], valid_input)
          expect(processor_result.result).to eq([4.0, '10'])
        end
      end

      context 'when operations are invalid' do
        let(:invalid_input) { '1 2 + 8 * 6 / *' }

        it 'returns an invalid operation result' do
          allow(parser_result).to receive(:parsed_elements).and_return(invalid_input.split(' '))

          processor_result = subject.process([], invalid_input)
          expect(processor_result).not_to be_valid
        end

        it 'returns the error for an invalid operation' do
          allow(parser_result).to receive(:parsed_elements).and_return(invalid_input.split(' '))

          processor_result = subject.process([], invalid_input)
          expect(processor_result.error).to eq('Invalid operation: 4.0 *')
        end

        it 'returns the error only for the first invalid operation, even if there are more on the stack' do
          multiple_input_errors = invalid_input + ' + 4 / /'
          allow(parser_result).to receive(:parsed_elements).and_return(multiple_input_errors.split(' '))

          processor_result = subject.process([], multiple_input_errors)
          expect(processor_result.error).to eq('Invalid operation: 4.0 *')
        end
      end
    end
  end
end
