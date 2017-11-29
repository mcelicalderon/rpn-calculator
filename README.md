# RPN Calculator

Simple RPN calculator

[![Build Status](https://travis-ci.org/mcelicalderon/rpn-calculator.svg?branch=master)](https://travis-ci.org/mcelicalderon/rpn-calculator)

### Solution Description

This RPN calculator has been implemented as a [RubyGem](https://rubygems.org/).
As it is a CLI tool, the gem includes a binary file you can use once the gem is
installed.

To fulfill the first requirement, the main `IoProcessor` class takes a `IoInterface`
object as one of its arguments. The gem uses `stdin` and `stdout` as its default
interface, but it can be easily replaced with any other.

The solution also handles input with two filtering steps. First checks input
for invalid character (everything but numbers and allowed operations) and then
checks that the input numbers are actually valid numbers. Ending the program
execution is handled at the specific `IoInterface` object. The input processor
will stop program execution as soon as reading from the `IoInterface` returns nil.
The calculator supports any input format as long as it makes sense. It also supports
expressions long as the user wants as long as they are valid.
Output will be displayed fir every valid result, error, or elements present in the
operation stack.

All the processing steps return a `Result` object that can be valid or invalid.
This objects are used to pass results to the next step, or return the error message
until it can be displayed through the `IoInterface`.

The operation processor receives all the handlers for every operation it can handle
(+, -, /, \* in this case). Then operates from left to right accumulating partial results
so they can be used in longer expressions.

### Solution Technical Reasoning
Many classes were created so they are not responsible for more than one thing in.
Result classes where used to encapsulate success or failure logic of each operation,
while providing a data structure whose interface is also tested.
Supported operations are injected as well as the interface handler at the applications
top level and handled at the lowest levels of the application without a problem.
Guard clauses are widely used to avoid nested conditionals or even conditionals sometimes.

Parsing of the input took a more complex turn than just splitting input separated
by a character. This way, any input is valid or handled by the application correctly.

### If I had More Time to Work on the project (I might, later)

Something I would definitively improve if I had more time to work on this, would be
the tests. I could have separated unit from integration specs in a better way some times,
and also test many other scenarios. I would also find the time to refactor some
iterative parts of the code that could probably be simplified.

Another thing I would like to add to the CLI tool is the ability to parse options
so it can use different interfaces or other configs. This shouldn't take long.

### How to Run
#### Install
This project has been published to [RubyGems](https://rubygems.org/). So, to use it,
you can install the tool like any other gem (assuming you have rubygems installed on your system). If you don't have rubygems installed check the
[installation steps here](https://rubygems.org/pages/download).

```bash
$ gem install rpn-calculator
```

to do it locally, you can also try:

```bash
$ git clone https://github.com/mcelicalderon/rpn-calculator.git
$ cd rpn-calculator
$ gem build rpn-calculator.gemspec
$ gem install rpn-calculator-0.3.0.gem
```

**Note:** if you don't want to install RubyGems you can also try running the binary file
directly as shown in the next step.
#### Run

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

#### Sample Input/Output

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
