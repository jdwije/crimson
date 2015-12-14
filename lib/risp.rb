require "risp/version"
require "risp/parser"
require "risp/std_env"
require "risp/interpreter"

module Risp

  def self.parse program
    return Parser.new.parse(program)
  end

  def self.repl
    interpreter = Risp::Interpreter.new
    parser = Risp::Parser.new
    env = Risp::StdEnv.new

    repl = -> prompt do
      print prompt
      input = gets.chomp!
      exit if input == 'exit'
      puts interpreter.eval(parser.parse(input), env)
    end

    loop do
      repl[">> "]
    end
  end

end
