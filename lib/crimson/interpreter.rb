module Crimson
  class Interpreter
    def eval(x, env)
      return env[x] if x.is_a? Symbol
      return x if !x.is_a? Array
      # handle rest
      case x[0]
      when :quote then x[1..-1]
      when :if
        _, test, conseq, alt = x
        eval(eval(test, env) ? conseq : alt, env)
      when :set! then env.set(x[1], eval(x[2], env))
      when :define then env[x[1]] = eval(x[2], env)
      when :lambda
        _, vars, exp = x
        Proc.new{|*args| eval(exp, Crimson::StdEnv.new(vars, args, env))}
      when :begin
        x[1..-1].inject([nil, env]) { |val_env, exp|
          [eval(exp, val_env[1]), val_env[1]]
        }[0]
      when :callcc
        f = eval(x[1], env)
        callcc {|cont| f.call( lambda{|x| cont.call(x)} ) }
      else
        exps = x.map{|exp| eval(exp, env)}
        exps[0].call(*exps[1..-1])
      end
    end

  end
end
