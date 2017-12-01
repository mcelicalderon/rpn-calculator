module RPNCalculator
  class CLI
    def initialize(io_interface, operation_processor)
      @io_interface = io_interface
      @input_stack  = []
      @operation_processor = operation_processor
    end

    def start
      while (input_expression = io_interface.read_input)
        processor_result = operation_processor.process(input_expression, input_stack)

        if processor_result.valid?
          print_result_array(processor_result.result)
          @input_stack = processor_result.result
        else
          io_interface.display_output(processor_result.error)
        end
      end
    end

    private

    attr_reader :io_interface, :operation_processor, :input_stack

    def print_result_array(result)
      io_interface.display_output(result.join(' '))
    end
  end
end
