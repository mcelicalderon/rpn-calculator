module RPNMario
  class Calculator
    INVALID_ARGUMENTS_REGEX = /[^\d\s\+\-\/\*\.]/.freeze
    ALLOWED_OPERANDS        = ['+', '-', '/', '*'].freeze

    def initialize(io_interface)
      @io_interface    = io_interface
      @input_stack     = []
      @input_validator = Input::Validator.new(INVALID_ARGUMENTS_REGEX)
      @input_parser    = Input::Parser.new(ALLOWED_OPERANDS)
    end

    def start
      while input = io_interface.read_input
        next unless input_valid?(input)
        next unless parsing_valid?(input)
      end
    end

    private

    attr_reader :input_stack, :io_interface, :input_validator, :input_parser

    def parsing_valid?(input)
      parsing_result = input_parser.parse(input)
      unless parsing_result.valid?
        print_validation_error(parsing_result)
      end
      parsing_result.valid?
    end

    def input_valid?(input)
      validation_result = input_validator.validate(input)
      unless validation_result.valid?
        print_validation_error(validation_result)
      end
      validation_result.valid?
    end

    def print_validation_error(result)
      io_interface.display_output(result.error)
    end
  end
end
