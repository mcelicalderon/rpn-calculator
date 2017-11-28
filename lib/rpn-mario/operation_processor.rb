module RPNMario
  class OperationProcessor
    def initialize(allowed_operands, input_validator, input_parser)
      @aallowed_operands = allowed_operands
      @input_validator   = input_validator
      @input_parser      = input_parser
    end

    def process(input)
      validator_result = input_validator.validate(input)
      return Result::Processor.new([], validator_result.error) unless validator_result.valid?

      parser_result = input_parser.parse(input)
      return Result::Processor.new([], parser_result.error) unless parser_result.valid?
    end

    private

    attr_reader :input_validator, :input_parser, :allowed_operands
  end
end
