# RPN Calculator

Simple RPN calculator

[![Build Status](https://travis-ci.org/mcelicalderon/rpn-calculator.svg?branch=master)](https://travis-ci.org/mcelicalderon/rpn-calculator)
[![Gem Version](https://badge.fury.io/rb/rpn-calculator.svg)](https://badge.fury.io/rb/rpn-calculator)

### How to Run
#### Install
```bash
$ gem install rpn-calculator
```

to do it locally, you can also try:

```bash
$ git clone https://github.com/mcelicalderon/rpn-calculator.git
$ cd rpn-calculator
$ gem build rpn-calculator.gemspec
$ gem install rpn-calculator-0.4.0.gem
```

**Note:** if you don't want to install RubyGems you can also try running the binary file
directly as shown in the next step.
#### Run

##### As a CLI Tool

If you installed the tool as a Gem, you should be able to call the binary directly:

```bash
$ rpn-calculator
```

If not, just run the bin!

```bash
$ git clone https://github.com/mcelicalderon/rpn-calculator.git
$ cd rpn-calculator
$ ./bin/rpn-calculator
```

##### As an imported module from your code

```ruby
require 'rpn-calculator'

# calculus is a RPNCalculator::Result::Operation
calculus = RPNCalculator.calculate('1 2 3 4 +-+')
# result can be an array with the result of the operation or an error message
# for an invalid expression. The result is an array where the only element
# is the actual result if the expression was complete
result = calculus.valid? ? calculus.result : calculus.error
# result => [-4.0]

# Array size is greater than one when an expression is correct but incomplete
calculus = RPNCalculator.calculate('10 1 2 3 4 +-+')
# calculus.result => ['10', -4.0]

# if the expression has errors
calculus = RPNCalculator.calculate('1 2 3 4 +-+/')
# calculus.valid? => false
# calculus.error => "Invalid operation: -4.0 /"
```

#### Sample CLI Input/Output

```bash
$ rpn-calculator
> 10
10
> 15
10 15
> +
25.0
> 3/
8.333333333333334
> 5*4 - 8 + 2*
91.33333333333334
> q
```

```bash
> 1 2 3 4 +-+
-4.0
> 10 2 3
-4.0 10 2 3
> *
-4.0 10 6.0
> */
-0.06666666666666667
> 12 * 15 +
14.2
> q
```

```bash
$ rpn-calculator
> 10
10
> 4 &
Invalid characters: &
> 5.1*
51.0
> 5.8.1 +
Invalid operators or numbers: 5.8.1
> 25 -
26.0
> q
```

```bash
> 15
15
> 13
15 13
> +
28.0
> *
Invalid operation: 28.0 *
> 1+
29.0
> 4.5. +
Invalid operators or numbers: 4.5.
> 4.5  
29.0 4.5
> +
33.5
> q
```
