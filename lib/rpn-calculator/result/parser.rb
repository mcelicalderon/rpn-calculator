require 'rpn-calculator/result/input'

module RPNCalculator
  module Result
    class Parser < Input
      def initialize(parsed_elements = [], invalid_elements = [])
        @parsed_elements  = parsed_elements
        @invalid_elements = invalid_elements
      end

      def valid?
        invalid_elements.empty?
      end

      def error
        "Invalid operators or numbers: #{invalid_element_list}" unless valid?
      end

      def result
        @parsed_elements
      end

      private

      attr_reader :invalid_elements

      def invalid_element_list
        invalid_elements.join(', ')
      end
    end
  end
end
