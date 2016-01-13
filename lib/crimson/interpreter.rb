module Crimson
  class Interpreter

    def initialize(environment)
      @global_env = environment
      @_append, @_cons, @_let = "append cons let".split.map { |s| s.to_sym }
      @macro_table = {:let => method(:let)} ## More macros can go here
      # load_built_in()
    end

    # loads built-in language definitions.
    def load_build_in
      parser = Crimson::Sexpistol.new
      Dir.glob(File.dirname(__FILE__) + '/../built-in/*.scm') do |file|
        next if file == '.' or file == '..'
        self.eval(expand(parser.parse(File.read(file))))
      end
    end

    # loads a standard library package.
    def load_standard_library_package(package)
      parser = Crimson::Sexpistol.new
      Dir.glob(File.dirname(__FILE__) + "/../standard-library/#{package}.scm") do |file|
        next if file == '.' or file == '..'
        self.eval(expand(parser.parse(File.read(file))))
      end
    end

    def eval(x, env = @global_env)
      while true
        return env[x] if x.is_a? Symbol
        return x if !x.is_a? Array
        # handle rest
        case x[0]
        when :quote then return x[1..-1]
        when :if
          _, test, conseq, alt = x
          x = eval(test, env) ? conseq : alt
        when :set! then return env.set(x[1], eval(x[2], env))
        when :define then return env[x[1]] = eval(x[2], env)
        when :lambda
          _, vars, exp = x
          return Crimson::Procedure.new(self, vars, exp, env)
        when :begin
          x[1..-1].each do |exp|
            eval(exp, env)
            x = x[-1]
          end
        when :callcc
          f = eval(x[1], env)
          callcc {|cont| f.call( lambda {|xx| cont.call(xx)} ) }
        else
          exps = x.map{ |exp| eval(exp, env) }
          proc = exps.slice!(0)
          if proc.is_a? Crimson::Procedure
            x = proc.body
            env = Crimson::Environment.new(
              proc.parameters, exps, proc.environment)
          else
            return proc.call(*exps[0..-1])
          end
        end
      end
    end

    # Signal a syntax error if +predicate+ of syntax +x+ is false.
    def require(x, predicate, msg="wrong length")
      raise SyntaxError, "#{x.to_s}: #{msg}" unless predicate == true
    end

    # Walk the tree of +x+ making optimizations and signaling errors
    # +top_level+ is a boolean indicating whether we are at the top
    # level of an expansion.
    def expand(x, top_level = true)
      raise Exception, "x #{x} is undefined" if x == nil
      raise Exception, "x #{x} is an empty array" if (x.is_a?(Array) && x.size == 0)
      return x if !x.is_a?(Array)

      if x[0] == :quote                 # (quote exp)
        require(x, (x.size == 2))
        return x
      elsif x[0] == :if
        x << nil if x.size == 3     # (if t c) => (if t c nil)
        require(x, (x.size == 4))
        # XXX: need to come back to this
        return x # x.inject { |exp| expand(exp) }
      elsif x[0] == :set
        require(x, (x.size == 3))
        var = x[1] # (set! non-var exp) => Error
        require(var, (var.is_a?(Symbol)), 'can set! only a symbol')
        return [:set, var, expand(x[2])]
      elsif x[0] == :define or x[0] == :"define-macro"
        require(x, (x.size >= 3))
        _def, v, body = x[0], x[1], x[2]
        if v.is_a?(Array)             # (define (f args) body)
          f, args = v[0], v[1..-1]        #  => (define f (lambda (args) body))
          return expand([_def, f, [:lambda, args] + body])
        else
          require(x, (x.size == 3))
          require(x, (v.is_a?(Symbol)), 'can define only a symbol')
          exp = expand(x[2])
          if _def == :"define-macro"
            require(x, (top_level != false), 'define-macro only allowed at top level')
            proc = self.eval(exp)
            require(proc, (proc.is_a?(Crimson::Procedure)),
                    'macro must be a procedure')
            @macro_table[v] = proc    # (define-macro v proc)
            return nil                #  => nil; add v => proc to @macro_table.
          end
          return [:define, v, exp]
        end
      elsif x[0] == :begin
        if x.size == 1
          return nil        # (begin) => None
        else
          exps = []
          x.map { |exp|
            exps << expand(exp)
          }
          return exps
        end
      elsif x[0] == :lambda                # (lambda (x) e1 e2)
        require(x, (x.size >= 3))          #  => (lambda (x) (begin e1 e2))
        vars, body = x[1], x[2..-1]
        require(vars, (vars.is_a?(Array)), 'illegal lambda argument list')
        vars.each { |arg|
          require(arg, (arg.is_a?(Symbol)), 'illegal lambda argument list')
        }
        exp =  body.size == 1 ? body[0] : [:begin] << body
        return [:lambda, vars, expand(exp)]
      elsif x[0] == :quasiquote            # `x => expand_quasiquote(x)
        require(x, (x.size == 2))
        return expand_quasiquote(x[1])
      elsif x[0].is_a?(Symbol) && @macro_table.include?(x[0])
        return expand(@macro_table[x[0]].call(*x[1]), top_level) # (m arg...)
      else                              #        => macroexpand if m isa macro
        return x.map { |exp| expand(exp) }            # (f arg...) => expand each
      end
    end

    # defines a marcro described by +*args+
    def let(*args)
      args = Array.new(*args)
      x = cons(_let, args)
      require(x, (args.size > 1), 'macro or arguments undefined')
      bindings, body = args[0], args[1]
      bindings.each { |b|
        require(b, (b.is_a?(Array) && b.size == 2 && b[0].is_a?(Symbol)),
                'illegal binding list')
      }
      vars, vals = zip(*bindings)
      return [[_lambda, list(vars)] + map(expand, body)] + map(expand, vals)
    end
  end
end
