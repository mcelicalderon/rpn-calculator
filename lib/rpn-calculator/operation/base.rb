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
        raise 'must implement in subclass'
      end

      def float_operands
        operands.map { |operator| Float(operator) }
      end
    end
  end
end
