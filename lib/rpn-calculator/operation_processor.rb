module RPNCalculator
  class OperationProcessor
    def initialize(operation_classes, input_validator, input_parser)
      @input_validator   = input_validator
      @input_parser      = input_parser
      @operation_classes = operation_classes
      @operation_symbols = @operation_classes.keys
    end

    def process(previous_operations, input)
      validator_result = input_validator.validate(input)
      return Result::Processor.new([], validator_result.error) unless validator_result.valid?

      parser_result = input_parser.parse(input)
      return Result::Processor.new([], parser_result.error) unless parser_result.valid?
      process_operations(previous_operations + parser_result.parsed_elements)
    end

    private

    attr_reader :input_validator, :input_parser, :operation_classes, :operation_symbols

    def process_operations(operations)
      operation_stack = []
      while operations.size > 0
        element = operations.shift
        if operation_symbols.include?(element)
          result = operation_classes.fetch(element).new(operation_stack).result
          return invalid_processor_result(result) unless result.valid?

          operation_stack = [result.result]
        else
          operation_stack.push(element)
        end
      end
      Result::Processor.new(operation_stack)
    end

    def invalid_processor_result(result)
      Result::Processor.new([], result.error)
    end
  end
end
