module Crimson
  class Interpreter
    def eval(x, env)
      while true
        return env[x] if x.is_a? Symbol
        return x if !x.is_a? Array

        # handle rest
        case x[0]
        when :quote then x[1..-1]
        when :if
          _, test, conseq, alt = x
          x = eval(test, env) ? conseq : alt
        when :set! then env.set(x[1], eval(x[2], env))
        when :define then env[x[1]] = eval(x[2], env)
        when :lambda
          _, vars, exp = x
          Proc.new{|*args| eval(exp, Crimson::Environment.new(vars, args, env))}
        when :begin
          x[1..-1].each do |exp|
            eval(exp, env)
            x = x[-1]
          end
        when :callcc
          f = eval(x[1], env)
          callcc {|cont| f.call( lambda{|x| cont.call(x)} ) }
        else
          exps = x.map{|exp| eval(exp, env)}
          proc = exps[0]
          if proc.kind_of? Crimson::Procedure
            x = proc
            env = Crimson::Environment.new(
              proc.parameters, exps, proc.env)
          else
            return proc.call(*exps[1..-1])
          end
        end
      end
    end

  end
end
