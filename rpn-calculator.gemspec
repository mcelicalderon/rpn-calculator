# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rpn-calculator/version'

Gem::Specification.new do |spec|
  spec.name          = "rpn-calculator"
  spec.version       = RPNCalculator::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.authors       = ["Mario Celi"]
  spec.email         = ["mcelicalderon@gmail.com"]

  spec.required_ruby_version = '>= 1.9.3'

  spec.summary       = "Basic RPN Calculator"
  spec.homepage      = "https://github.com/mcelicalderon/rpn-calculator"
  spec.license       = "MIT"

  spec.files         = `git ls-files -- lib/*`.split("\n").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_path  = "lib"

  spec.add_development_dependency "rspec", "~> 3.7"
end
