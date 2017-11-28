module RPNCalculator
  module IoInterface
    class Abstract
      def read_input
        raise 'Must implement in subclass'
      end

      def display_output
        raise 'Must implement in subclass'
      end
    end
  end
end
