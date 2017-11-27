require 'rpn-mario/calculator'
require 'rpn-mario/io_interface/abstract'
require 'rpn-mario/io_interface/standard'

module RPNMario
  module_function

  def start
    # Here is where we could read and write to another input
    # using stdin and stdout by default
    calculator = Calculator.new(IoInterface::Standard.new)
    calculator.start
  end
end
