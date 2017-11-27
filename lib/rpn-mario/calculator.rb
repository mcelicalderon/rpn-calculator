module RPNMario
  class Calculator
    ALLOWED_OPERATORS = %w[+ - * /].freeze

    def initialize(io_interface)
      @io_interface = io_interface
      @input_stack  = []
    end

    def start
      while input = io_interface.read_input
        @input_stack += input.split(' ')
        operands = input_stack_operands
        next if operands.empty?

        result = process_input_operands
      end
    end

    private

    attr_reader :input_stack, :io_interface

    def input_stack_operands
      (ALLOWED_OPERATORS & input_stack)
    end

    def process_input_operands(operands)
      if operands.size == 1
        single_operand_operation(input_stack.pop)
      else
        multiple_operand_operation(operands)
      end
    end

    def single_operand_operation(operand)
      input_stack.inject(0)
    end
  end
end
