require "crimson/version"
require "crimson/environment"
require "crimson/procedure"
require "crimson/interpreter"
require "crimson/console"
require "crimson/parser"

module Crimson

  def self.parse program
    return Parser.new.parse(program)
  end

end
