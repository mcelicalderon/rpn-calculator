require 'spec_helper'

RSpec.describe RPNCalculator::InputProcessor do
  let(:input_validator)     { instance_double(RPNCalculator::Input::Validator) }
  let(:input_parser)        { instance_double(RPNCalculator::Input::Parser) }
  let(:operation_processor) { instance_double(RPNCalculator::OperationProcessor) }
  let(:validator_result)    { double(:validator_result, valid?: true) }
  let(:parser_result)       { double(:parser_result, valid?: true, result: ['1', '2', '+']) }
  let(:operation_result)    { double(:operation_result, valid?: true) }

  describe '#process' do
    subject do
      described_class.new(operation_processor, input_validator, input_parser)
    end

    before do
      allow(input_validator).to     receive(:validate).and_return(validator_result)
      allow(input_parser).to        receive(:parse).and_return(parser_result)
      allow(operation_processor).to receive(:process).and_return(operation_result)
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
      let(:parser_result) { double(:parser_result, valid?: false, error: 'Invalid input after parsing') }

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
      context 'when operations are valid' do
        let(:operation_result) { double(:operation_result, valid?: true, result: [10.0]) }

        it 'returns a valid operation result' do
          processor_result = subject.process("Parsing is mocked so don't mind this")
          expect(processor_result).to be_valid
        end

        it 'returns a valid operation result with the correct operation value' do
          processor_result = subject.process("Parsing is mocked so don't mind this")
          expect(processor_result.result).to eq([10.0])
        end
      end

      context 'when operations are invalid' do
        let(:operation_result) { double(:operation_result, valid?: false, error: 'failed operation error') }

        it 'returns an invalid operation result' do
          processor_result = subject.process("Parsing is mocked so don't mind this")
          expect(processor_result).not_to be_valid
        end

        it 'returns the error for an invalid operation' do
          processor_result = subject.process("Parsing is mocked so don't mind this")
          expect(processor_result.error).to eq('failed operation error')
        end
      end
    end
  end
end
