require "thor"

module Crimson

  # Console
  # -------
  # A command line helper class for the Crimson system.
  #
  # author:     jdw
  # date:       15 Dec 2015
  # license:    MIT
  # copyright:  Jason Wijegooneratne
  class Console < Thor
    include Thor::Actions

    def initialize(*args)
      super(*args)
      @interpreter = Crimson::Interpreter.new(Crimson::Environment.new)
      @parser = Crimson::Sexpistol.new
    end

    desc "repl", "start an interactive risp REPL"
    def repl
      repl = -> prompt do
        print prompt
        #      input = gets.chop
        input = ask('')
        exit if input == 'exit'
        begin
          tree = @parser.parse(input)
          tree.each { |exp|
            puts @interpreter.eval(@interpreter.expand(exp))
          }
        rescue Exception => e
          puts "ERROR: #{e.message}"
          puts e.backtrace
        end
      end

      loop do
        repl[">>"]
      end
    end

    desc "execute PROGRAM", "execute PROGRAM string as risp code"
    option :file, :type => :boolean, :desc => "read and execute from file"
    def execute(program)
      if options.key? 'file'
        file = File.open(program, "rb")
        contents = file.read
      else
        contents = program
      end
      tree = @parser.parse(contents)
      tree.each { |exp|
        @interpreter.eval(@interpreter.expand(exp))
      }
    end
  end

end
