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
  INVALID_ARGUMENTS_REGEX = /[^\d\s\.#{Regexp.quote(ALLOWED_OPERATORS.join)}]/
  OPERATION_PROCESSOR     = OperationProcessor.new(OPERATION_CLASSES).freeze
  INPUT_PROCESSOR         = InputProcessor.new(
    OPERATION_PROCESSOR,
    Input::Validator.new(INVALID_ARGUMENTS_REGEX),
    Input::Parser.new(ALLOWED_OPERATORS)
  ).freeze

  module_function

  def start_cli_tool
    # Here is where we could read and write to another input
    # using stdin and stdout by default
    processor = CLI.new(IoInterface::Standard.new, INPUT_PROCESSOR)
    processor.start
  end

  def calculate(expression)
    INPUT_PROCESSOR.process(expression)
  end
end
