require "risp/version"
require "risp/parser"
require "risp/std_environment"

module Risp
  def self.parse program
    return Parser.new.parse(program)
  end
end
