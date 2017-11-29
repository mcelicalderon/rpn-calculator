module RPNCalculator
  class OperationProcessor
    def initialize(allowed_operators, input_validator, input_parser)
      @aallowed_operators = allowed_operators
      @input_validator    = input_validator
      @input_parser       = input_parser
    end

    def process(previous_operations, input)
      validator_result = input_validator.validate(input)
      return Result::Processor.new([], validator_result.error) unless validator_result.valid?

      parser_result = input_parser.parse(input)
      return Result::Processor.new([], parser_result.error) unless parser_result.valid?

      process_operations(previous_operations + parser_result.parsed_elements)
    end

    private

    attr_reader :input_validator, :input_parser, :allowed_operators

    def process_operations(operations)

    end
  end
end
