require 'rpn-calculator/operation/base'

module RPNCalculator
  module Operation
    class Addition < Base
      def result
        return Result::Operation.new([], operands) unless valid?

        Result::Operation.new(float_operands.reduce(&:+))
      end

      private

      def valid?
        operands.size >= 2
      end
    end
  end
end
