require 'spec_helper'

RSpec.describe RPNCalculator::OperationProcessor do
  let(:operation_classes) do
    {
      '+' => RPNCalculator::Operation::Addition,
      '-' => RPNCalculator::Operation::Subtraction,
      '*' => RPNCalculator::Operation::Multiplication,
      '/' => RPNCalculator::Operation::Division
    }.freeze
  end

  describe '#process' do
    subject { described_class.new(operation_classes) }

    context 'when the expression is invalid' do
      let(:invalid_expression) { ['1', '2', '+', '+'] }

      it 'returns an invalid processor result' do
        processor_result = subject.process(invalid_expression)
        expect(processor_result).not_to be_valid
      end

      it 'returns a processor result with an error message' do
        processor_result = subject.process(invalid_expression)
        expect(processor_result.error).to eq('Invalid operation: 3.0 +')
      end
    end

    context 'when the expression is valid' do
      let(:valid_expression) { ['1', '2', '+', '8', '*', '6', '/']  }

      it 'returns a valid operation result' do
        processor_result = subject.process(valid_expression)
        expect(processor_result).to be_valid
      end

      it 'returns a valid operation result with the correct operation value' do
        processor_result = subject.process(valid_expression)
        expect(processor_result.result).to eq([4.0])
      end

      it 'returns correct operation value plus remaining elements in the stack' do
        processor_result = subject.process(valid_expression + ['10'])
        expect(processor_result.result).to eq([4.0, 10.0])
      end

      context 'when operations are correct in a more complex format' do
        let(:valid_expression) { ['1', '2', '3', '4', '+', '-', '+', '2', '/']  }

        it 'returns a valid operation result' do
          processor_result = subject.process(valid_expression)
          expect(processor_result).to be_valid
        end

        it 'returns a valid operation result with the correct operation value' do
          processor_result = subject.process(valid_expression)
          expect(processor_result.result).to eq([-2.0])
        end

        it 'returns correct operation value plus remaining elements in the stack' do
          processor_result = subject.process(valid_expression + ['10'])
          expect(processor_result.result).to eq([-2.0, 10.0])
        end
      end
    end
  end
end
