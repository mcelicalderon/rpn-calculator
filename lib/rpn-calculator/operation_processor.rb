module RPNCalculator
  class OperationProcessor
    def initialize(operation_classes)
      @operation_classes = operation_classes
      @operation_symbols = @operation_classes.keys
    end

    def process(parsed_expression)
      result_stack = parsed_expression.inject([]) do |stack, element|
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

    private

    attr_reader :operation_classes, :operation_symbols

    def invalid_processor_result(result)
      Result::Processor.new([], result.error)
    end
  end
end
