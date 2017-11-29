require 'rpn-calculator/operation/base'

module RPNCalculator
  module Operation
    class Addition < Base
      def result
        return invalid_operation_result unless valid?

        Result::Operation.new(float_operands.reduce(&:+))
      end
    end
  end
end
