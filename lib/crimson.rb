require "crimson/version"
require "crimson/parser"
require "crimson/environment"
require "crimson/interpreter"
require "crimson/console"

module Crimson

  def self.parse program
    return Parser.new.parse(program)
  end

end
