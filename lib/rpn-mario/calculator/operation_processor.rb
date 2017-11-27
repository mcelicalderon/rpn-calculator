module RPNMario
  module Calculator
    class OperationProcessor
      def initialize(operator:, operands: [])
        @operator = operator
        @operands = operands
      end
    end
  end
end
