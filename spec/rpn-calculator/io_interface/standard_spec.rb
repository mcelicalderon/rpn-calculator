require 'spec_helper'

RSpec.describe RPNCalculator::IoInterface::Standard do
  subject { described_class.new }

  describe '#read_input' do
    it 'returns a value gathered from STDIN' do
      allow(STDIN).to receive(:gets).and_return("1 2 +\n")

      expect(subject.read_input).to eq('1 2 +')
    end

    it 'prints a > characters before requesting user input' do
      allow(STDIN).to receive(:gets)

      expect { subject.read_input }.to output('> ').to_stdout
    end

    it 'returns nil if the user input is nil' do
      allow(STDIN).to receive(:gets).and_return(nil)

      expect(subject.read_input).to be_nil
    end

    it 'returns nil if the user input is `q`' do
      allow(STDIN).to receive(:gets).and_return("q\n")

      expect(subject.read_input).to be_nil
    end
  end

  describe '#display_output' do
    it 'displays a given value to STDOUT' do
      expect { subject.display_output(37) }.to output("37\n").to_stdout
    end
  end
end
