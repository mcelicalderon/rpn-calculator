module RPNMario
  class IoProcessor
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
        validator_result = input_validator.validate(input)
        unless validator_result.valid?
          print_validation_error(validator_result)
          next
        end

        parsed_result = input_parser.parse(input)
        unless parsed_result.valid?
          print_validation_error(parsed_result)
          next
        end

        parsed_result.parsed_elements
      end
    end

    private

    attr_reader :input_stack, :io_interface, :input_validator, :input_parser

    def print_validation_error(result)
      io_interface.display_output(result.error)
    end
  end
end
