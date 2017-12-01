module RPNCalculator
  class InputProcessor
    def initialize(operation_processor, input_validator, input_parser)
      @input_validator     = input_validator
      @input_parser        = input_parser
      @operation_processor = operation_processor
    end

    def process(input_expression, previous_operations = [])
      validator_result = input_validator.validate(input_expression)
      return invalid_processor_result(validator_result) unless validator_result.valid?

      parser_result = input_parser.parse(input_expression)
      return invalid_processor_result(parser_result) unless parser_result.valid?

      operation_result = operation_processor.process(
        previous_operations + parser_result.result
      )
      return invalid_processor_result(operation_result) unless operation_result.valid?

      Result::Processor.new(operation_result.result)
    end

    private

    attr_reader :input_validator, :input_parser, :operation_processor

    def invalid_processor_result(result)
      Result::Processor.new([], result.error)
    end
  end
end
