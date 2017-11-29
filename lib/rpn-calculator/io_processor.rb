require 'rpn-calculator/operation/addition'
require 'rpn-calculator/operation/subtraction'
require 'rpn-calculator/operation/multiplication'
require 'rpn-calculator/operation/division'

module RPNCalculator
  class IoProcessor
    OPERATION_CLASSES = {
      '+' => Operation::Addition,
      '-' => Operation::Subtraction,
      '*' => Operation::Multiplication,
      '/' => Operation::Division
    }.freeze
    ALLOWED_OPERATORS       = OPERATION_CLASSES.keys.freeze
    INVALID_ARGUMENTS_REGEX = /[^\d\s\+\-\/\*\.]/.freeze

    def initialize(io_interface)
      @io_interface = io_interface
      @input_stack  = []
      @operation_processor = OperationProcessor.new(
        OPERATION_CLASSES,
        Input::Validator.new(INVALID_ARGUMENTS_REGEX),
        Input::Parser.new(ALLOWED_OPERATORS)
      )
    end

    def start
      while (input = io_interface.read_input)
        # operate
      end
    end

    private

    attr_reader :input_stack, :io_interface
  end
end
