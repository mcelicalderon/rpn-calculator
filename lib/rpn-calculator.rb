Dir.glob('lib/**/*.rb').each do |file|
  require file.gsub('lib/', '').gsub('.rb', '')
end

module RPNCalculator
  OPERATION_CLASSES = {
    '+' => Operation::Addition,
    '-' => Operation::Subtraction,
    '*' => Operation::Multiplication,
    '/' => Operation::Division
  }.freeze
  ALLOWED_OPERATORS       = OPERATION_CLASSES.keys.freeze
  INVALID_ARGUMENTS_REGEX = /[^\d\s\+\-\/\*\.]/.freeze

  module_function

  def start
    operation_processor = OperationProcessor.new(
      OPERATION_CLASSES,
      Input::Validator.new(INVALID_ARGUMENTS_REGEX),
      Input::Parser.new(ALLOWED_OPERATORS)
    )

    # Here is where we could read and write to another input
    # using stdin and stdout by default
    processor = IoProcessor.new(IoInterface::Standard.new, operation_processor)
    processor.start
  end
end
