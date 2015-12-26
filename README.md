# Crimson

*An embeddable R6RS Scheme implementation for Ruby*

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

```
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

## Inspiration

- http://norvig.com/lispy.html
- https://github.com/jcoglan/heist
