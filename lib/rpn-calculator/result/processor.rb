require 'rpn-calculator/result/input'

module RPNCalculator
  module Result
    class Processor < Input
      def initialize(result = [], error = nil)
        @result = result
        @error  = error
      end

      def valid?
        error.nil?
      end

      attr_reader :result, :error
    end
  end
end
