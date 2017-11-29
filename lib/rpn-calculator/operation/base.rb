module RPNCalculator
  module Operation
    class Base
      def initialize(operands)
        @operands = operands
      end

      def result
        raise 'must implement in subclass'
      end

      private

      attr_reader :operands

      def valid?
        operands.size == 2
      end

      def float_operands
        operands.map { |operator| Float(operator) }
      end

      def invalid_operation_result(operation)
        Result::Operation.new(operation, [], operands)
      end
    end
  end
end
