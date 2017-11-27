module RPNMario
  module Input
    class ParserResult
      def initialize(elements = [], error = nil)
        @error    = error
        @elements = elements
      end

      def valid?
        error.nil?
      end

      attr_reader :error, :elements
    end
  end
end
