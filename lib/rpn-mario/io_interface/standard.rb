module RPNMario
  module IoInterface
    class Standard < Abstract
      def read_input
        STDIN.gets.chomp
      end

      def display_output(result)
        puts result
      end
    end
  end
end
