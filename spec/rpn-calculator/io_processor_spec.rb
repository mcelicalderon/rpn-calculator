require 'spec_helper'

RSpec.describe RPNCalculator::IoProcessor do
  # let(:io_interface) { double(:test_io_interface) }
  #
  # subject { described_class.new(io_interface) }
  #
  # before do
  #   allow(io_interface).to receive(:display_output)
  # end
  #
  # describe '#start' do
  #   # context 'when input is always valid' do
  #   #   before do
  #   #     allow(io_interface).to receive(:read_input).and_return(
  #   #       '1 2', '5.1', '+', nil
  #   #     )
  #   #   end
  #
  #     # it 'outputs the result of a given operation' do
  #     #   expect(io_interface).to receive(:display_output).once.ordered.with(6)
  #     #   expect(io_interface).to receive(:display_output).once.ordered.with(3)
  #     #
  #     #   subject.start
  #     # end
  #   # end
  #   context 'when input is invalid' do
  #     it 'displays an error message when input has invalid characters' do
  #       allow(io_interface).to  receive(:read_input).and_return('1 2 p', '4', '1 + J', nil)
  #       expect(io_interface).to receive(:display_output).once.ordered.with('Invalid characters: p')
  #       expect(io_interface).to receive(:display_output).once.ordered.with('Invalid characters: J')
  #
  #       subject.start
  #     end
  #
  #     it 'displays an error message when input has invalid numbers after character validation' do
  #       allow(io_interface).to  receive(:read_input).and_return('1 2', '4 . .55', '1.1.5 + ', nil)
  #       expect(io_interface).to receive(:display_output).once.ordered.with('Invalid operator or numbers: .')
  #       expect(io_interface).to receive(:display_output).once.ordered.with('Invalid operator or numbers: 1.1.5')
  #
  #       subject.start
  #     end
  #   end
  # end
end
