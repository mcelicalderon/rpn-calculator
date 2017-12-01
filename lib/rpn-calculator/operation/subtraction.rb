require 'rpn-calculator/operation/base'

module RPNCalculator
  module Operation
    class Subtraction < Base
      def result
        return invalid_operation_result(operation_string) unless valid?

        Result::Operation.new(operation_string, operands.reduce(&:-))
      end

      private

      def operation_string
        '-'
      end
    end
  end
end
