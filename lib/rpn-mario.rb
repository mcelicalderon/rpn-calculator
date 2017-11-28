Dir.glob('lib/**/*.rb').each { |file| require File.expand_path(file) }

module RPNMario
  module_function

  def start
    # Here is where we could read and write to another input
    # using stdin and stdout by default
    processor = IoProcessor.new(IoInterface::Standard.new)
    processor.start
  end
end
