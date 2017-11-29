module RPNCalculator
  module Operation
    class Base
      def self.operate(operands)
        new(operands).result
      end

      def initialize(operands)
        @operands = operands.compact
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

      def operation_string
        raise 'must implement in subclass'
      end
    end
  end
end
