# Crimson

*An embeddable scheme implementation for ruby*

[![Build Status](https://travis-ci.org/jdwije/crimson.svg)](https://travis-ci.org/jdwije/crimson)

Crimson is a work-in-progress Scheme interpreter written in Ruby. It implements
a subset of the R6RS specification and adds back some flavor by exploiting the
Ruby run-time environment.

Crimson's focus is on Ruby inter-op, allowing you to use Ruby libraries and tools
inside Scheme with minimal friction.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'crimson'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install crimson

## Usage

Open a repl:

```
bin/crimson repl
```

Read and execute some code:

```
bin/crimson execute /path/to/code.scm
```

You can of course also embed Crimson within your Ruby applications:

```ruby
require 'crimson'

interpreter = Crimson::Interpreter.new
parser = Crimson::Parser.new
env = Crimson::Environment.new
program = '(define square (x) (* x x))'
           + '(display (square 3))'

puts interpreter.eval(parser.parse(program), env)
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jdwije/crimson.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

Additionally this software makes use of the most excellent SexPistol parser
library. It is distributed under the terms and conditions of the MIT license
and has been incorporated into this software, however the copyright remains
with its author, Aaron Gough. For more information see its [license](https://github.com/aarongough/sexpistol/blob/master/MIT-LICENSE).

## Inspiration

- http://norvig.com/lispy.html
- https://github.com/jcoglan/heist
- https://github.com/aarongough/sexpistol
