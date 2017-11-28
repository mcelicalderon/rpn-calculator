module RPNMario
  class IoProcessor
    INVALID_ARGUMENTS_REGEX = /[^\d\s\+\-\/\*\.]/.freeze
    ALLOWED_OPERANDS        = ['+', '-', '/', '*'].freeze

    def initialize(io_interface)
      @io_interface = io_interface
      @input_stack  = []
      @operation_processor = OperationProcessor.new(
        ALLOWED_OPERANDS,
        Input::Validator.new(INVALID_ARGUMENTS_REGEX),
        Input::Parser.new(ALLOWED_OPERANDS)
      )
    end

    def start
      while (input = io_interface.read_input)
        # operate
      end
    end

    private

    attr_reader :input_stack, :io_interface

    def print_validation_error(result)
      io_interface.display_output(result.error)
    end
  end
end
