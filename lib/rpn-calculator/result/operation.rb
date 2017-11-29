module RPNCalculator
  module Result
    class Operation
      def initialize(operation, result, invalid_operation_elements = [])
        @operation                  = operation
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

      attr_reader :invalid_operation_elements, :operation

      def invalid_operation
        invalid_operation_elements.join(' ') + " #{operation}"
      end
    end
  end
end
