require 'spec_helper'

RSpec.describe RPNMario::Calculator do
  let(:io_interface) { double(:test_io_interface) }

  subject { described_class.new(io_interface) }

  before do
    allow(io_interface).to receive(:display_output)
  end

  describe '#start' do
    context 'when input is always valid' do
      before do
        allow(io_interface).to receive(:read_input).and_return(
          '1 2', '5', '+', '2', '/', nil
        )
      end

      # it 'outputs the result of a given operation' do
      #   expect(io_interface).to receive(:display_output).once.ordered.with(6)
      #   expect(io_interface).to receive(:display_output).once.ordered.with(3)
      #
      #   subject.start
      # end
    end
  end
end
