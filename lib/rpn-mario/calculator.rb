module RPNMario
  class Calculator
    INVALID_ARGUMENTS_REGEX = /[^\d\s\+\-\/\*\.]/.freeze

    def initialize(io_interface, input_validator)
      @io_interface    = io_interface
      @input_stack     = []
      @input_validator = Input::Validator.new(INVALID_ARGUMENTS_REGEX)
    end

    def start
      while input = io_interface.read_input

        # @input_stack += input.split(' ')
        # operands = input_stack_operands
        # next if operands.empty?
        #
        # result = process_input_operands
      end
    end

    private

    attr_reader :input_stack, :io_interface, :input_validator

    # def input_stack_operands
    #   (ALLOWED_OPERATORS & input_stack)
    # end
    #
    # def process_input_operands(operands)
    #   if operands.size == 1
    #     single_operand_operation(input_stack.pop)
    #   else
    #     multiple_operand_operation(operands)
    #   end
    # end
    #
    # def single_operand_operation(operand)
    #   input_stack.inject(0)
    # end
  end
end
