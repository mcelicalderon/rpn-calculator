module RPNMario
  module Input
    class Parser
      def initialize(allowed_operands)
        @allowed_operands = allowed_operands
      end

      def parse(input_string)
        parsed_input = clean_whitespace(
          join_consecutive_numbers(input_string.split(''))
        )
        errors = parsed_input_errors(parsed_input)
        message = errors.any? ? "Invalid operands or numbers: #{errors.join(', ')}" : nil
        ParserResult.new(parsed_input, message)
      end

      private

      attr_reader :allowed_operands

      def clean_whitespace(split_string)
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
          if index == 0 || !is_number_or_period?(split_string[index - 1])
            result << element
          elsif is_number_or_period?(split_string[index - 1]) && is_number_or_period?(element)
            result[-1] += element
          end
          result
        end
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
