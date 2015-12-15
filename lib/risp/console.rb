require "thor"

module Risp

  # Console
  # -------
  # A command line helper class for the RISP system.
  #
  # author:     jdw
  # date:       15 Dec 2015
  # license:    MIT
  # copyright:  Jason Wijegooneratne
  class Console < Thor
    include Thor::Actions

    def initialize(*args)
      super(*args)

      @interpreter = Risp::Interpreter.new
      @parser = Risp::Parser.new
      @env = Risp::StdEnv.new
    end

    desc "repl", "start an interactive risp REPL"
    def repl
      repl = -> prompt do
        print prompt
        #      input = gets.chop
        input = ask('')
          exit if input == 'exit'
        puts @interpreter.eval(@parser.parse(input), @env)
      end

      loop do
        repl[">> "]
      end
    end

    desc "execute FILE", "execute FILE as risp source code"
    def execute(file)
      puts "#{file}"
    end
  end

end
