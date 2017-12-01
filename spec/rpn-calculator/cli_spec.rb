require 'spec_helper'

RSpec.describe RPNCalculator::CLI do
  let(:io_interface) { double(:test_io_interface) }
  let(:operation_processor) do
    RPNCalculator::OperationProcessor.new(RPNCalculator::OPERATION_CLASSES)
  end
  let(:input_processor) do
    RPNCalculator::InputProcessor.new(
      operation_processor,
      RPNCalculator::Input::Validator.new(RPNCalculator::INVALID_ARGUMENTS_REGEX),
      RPNCalculator::Input::Parser.new(RPNCalculator::ALLOWED_OPERATORS)
    )
  end

  subject { described_class.new(io_interface, input_processor) }

  before do
    allow(io_interface).to receive(:display_output)
  end

  describe '#start' do
    context 'when input is always valid' do
      before do
        allow(io_interface).to receive(:read_input).and_return(
          '1 ', '5.1', '+', nil
        )
      end

      it 'outputs the result of a given operation' do
        expect(io_interface).to receive(:display_output).once.ordered.with('1')
        expect(io_interface).to receive(:display_output).once.ordered.with('1 5.1')
        expect(io_interface).to receive(:display_output).once.ordered.with('6.1')

        subject.start
      end
    end
    context 'when input is invalid' do
      it 'displays an error message when input has invalid characters' do
        allow(io_interface).to  receive(:read_input).and_return('1 2 p', '4', '1 + J', nil)

        expect(io_interface).to receive(:display_output).once.ordered.with('Invalid characters: p')
        expect(io_interface).to receive(:display_output).once.ordered.with('Invalid characters: J')

        subject.start
      end

      it 'displays an error message when input has invalid numbers after character validation' do
        allow(io_interface).to  receive(:read_input).and_return('1 2', '4 . .55', '1.1.5 + ', nil)

        expect(io_interface).to receive(:display_output).once.ordered.with('1 2')
        expect(io_interface).to receive(:display_output).once.ordered.with('Invalid operators or numbers: .')
        expect(io_interface).to receive(:display_output).once.ordered.with('Invalid operators or numbers: 1.1.5')

        subject.start
      end
    end
  end
end
