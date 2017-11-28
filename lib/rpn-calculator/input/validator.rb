module RPNCalculator
  module Input
    class Validator
      def initialize(invalid_arguments_regex)
        @invalid_arguments_regex = invalid_arguments_regex
      end

      def validate(input_string)
        invalid_characters = input_string.scan(invalid_arguments_regex)
        Result::Validator.new(invalid_characters)
      end

      private

      attr_reader :invalid_arguments_regex
    end
  end
end
