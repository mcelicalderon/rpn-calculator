module RPNMario
  module Input
    class ValidatorResult
      def initialize(error = nil)
        @error = error
      end

      def valid?
        error.nil?
      end

      attr_reader :error
    end
  end
end
