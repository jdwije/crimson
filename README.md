# RISP

*A Scheme derived calculator language*

RISP (Ruby-LISP) is a Scheme derived calculator language for performing complex
on-the-fly computation using a natural-language syntax. RISP is not just another
mathematics library, it ships with it's own interpreter which can be embedded
into your programs to bring RISP where you want it most. The RISP interpreter is
written in Ruby and can go where it goes. I wrote RISP to teach myself about
interpreters, Scheme, and such however I also want(ed) to make a more convienient
calculator that understands more than just numbers. I hope you enjoy it!

#### Example

```
# Calculate how many UTF8 chars we need to fill a 1 MB text file.
(1mb / (8bytes in mb))

# or more succinctly, bytes will be converted to mb implicitly
(1mb / 8 bytes)
```

RISP can be used to perform tabular data computation:

```
# open a data file
setq table = (open 'data.csv')
# calculate variance of column x & y and store it in a variable
setq variance = ((table columns) x y) variance
```

#### RISP is 3 things:

1. Scheme interpreter
2. Calulator DSL library
3. A REPL

The RISP interpreter is quite capabale and impliments a subset of the MIT scheme
specification. It inludes full REPL and support for advanced features such as
closures, hygenic macros, and.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'risp'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install risp

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/risp.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

