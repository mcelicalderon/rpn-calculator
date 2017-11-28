module RPNMario
  module Input
    class Parser
      def initialize(allowed_operands)
        @allowed_operands = allowed_operands
      end

      def parse(input_string)
        parsed_input = input_without_whitespace(
          join_consecutive_numbers(input_string.split(''))
        )
        invalid_elements = parsed_input_errors(parsed_input)
        Result::Parser.new(parsed_input, invalid_elements)
      end

      private

      attr_reader :allowed_operands

      def input_without_whitespace(split_string)
        split_string.select { |e| e!= ' ' }
      end

      def parsed_input_errors(parsed_input)
        parsed_input.inject([]) do |result, element|
          result << element unless allowed_operands.include?(element) || is_number?(element)
          result
        end
      end

      def join_consecutive_numbers(split_string)
        split_string.each_with_index.inject([]) do |result, (element, index)|
          if index == 0 || any_operand?([split_string[index - 1], element])
            result << element
          else
            result[-1] += element
          end
          result
        end
      end

      def any_operand?(elements)
        elements.any? { |e| !is_number_or_period?(e) }
      end

      def is_number_or_period?(number_string)
        number_string == '.' || is_number?(number_string)
      end

      def is_number?(number_string)
        true if Float(number_string)
      rescue ArgumentError
        false
      end
    end
  end
end
