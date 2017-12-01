module RPNCalculator
  class OperationProcessor
    def initialize(operation_classes, input_validator, input_parser)
      @input_validator   = input_validator
      @input_parser      = input_parser
      @operation_classes = operation_classes
      @operation_symbols = @operation_classes.keys
    end

    # Refator needed, process should receive parsed input
    def process(input_expression, previous_operations = [])
      validator_result = input_validator.validate(input_expression)
      return Result::Processor.new([], validator_result.error) unless validator_result.valid?

      parser_result = input_parser.parse(input_expression)
      return Result::Processor.new([], parser_result.error) unless parser_result.valid?

      process_operations(previous_operations + parser_result.parsed_elements)
    end

    private

    attr_reader :input_validator, :input_parser, :operation_classes, :operation_symbols

    def process_operations(operations)
      result_stack = operations.inject([]) do |stack, element|
        if operation_symbols.include?(element)
          result = operation_classes.fetch(element)
                                    .operate(stack.pop(2))
          return invalid_processor_result(result) unless result.valid?
          stack.push(result.result)
        else
          stack.push(element)
        end
        stack
      end
      Result::Processor.new(result_stack)
    end

    def invalid_processor_result(result)
      Result::Processor.new([], result.error)
    end
  end
end
