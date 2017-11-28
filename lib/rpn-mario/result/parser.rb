module RPNMario
  module Result
    class Parser
      def initialize(parsed_elements = [], invalid_elements = [])
        @parsed_elements  = parsed_elements
        @invalid_elements = invalid_elements
      end

      def valid?
        invalid_elements.empty?
      end

      def error
        "Invalid operands or numbers: #{invalid_element_list}" unless valid?
      end

      attr_reader :parsed_elements, :invalid_elements

      private

      def invalid_element_list
        invalid_elements.join(', ')
      end
    end
  end
end
