module RPNMario
  module IoInterface
    class Standard < Abstract
      def read_input
        print '> '
        input = STDIN.gets
        input.chomp unless input.nil? || input == "q\n"
      end

      def display_output(result)
        puts result
      end
    end
  end
end
