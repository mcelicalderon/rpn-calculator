module RPNMario
  module Input
    class Validator
      def initialize(invalid_arguments_regex)
        @invalid_arguments_regex = invalid_arguments_regex
      end

      def validate(input_string)
        invalid_characters = input_string.scan(invalid_arguments_regex)
        ValidatorResult.new(error_message(invalid_characters))
      end

      private

      attr_reader :invalid_arguments_regex

      def error_message(invalid_characters)
        return nil if invalid_characters.empty?
        "Invalid characters: #{invalid_characters.join(', ')}"
      end
    end
  end
end
