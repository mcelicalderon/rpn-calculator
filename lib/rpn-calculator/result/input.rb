module RPNCalculator
  module Result
    class Input
      def initialize
        raise 'Can not instantiate abstract class'
      end

      def valid?
        raise 'must implement in subclass'
      end

      def error
        raise 'must implement in subclass'
      end

      def result
        raise 'must implement in subclass'
      end
    end
  end
end
