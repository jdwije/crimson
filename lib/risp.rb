require "risp/version"
require "risp/parser"
require "risp/std_env"
require "risp/interpreter"
require "risp/console"

module Risp

  def self.parse program
    return Parser.new.parse(program)
  end

end
