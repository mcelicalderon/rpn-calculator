module RPNCalculator
  module Result
    class Operation
      def initialize(result, invalid_operation_elements = [])
        @result                     = result
        @invalid_operation_elements = invalid_operation_elements
      end

      def valid?
        invalid_operation_elements.empty?
      end

      def error
        "Invalid operation: #{invalid_operation}" unless valid?
      end

      attr_reader :result

      private

      attr_reader :invalid_operation_elements

      def invalid_operation
        invalid_operation_elements.join(' ')
      end
    end
  end
end
