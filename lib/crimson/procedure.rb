module Crimson
  class Procedure
    attr_accessor :parameters, :environment, :body, :context

    def initialize(ctx, parms, body, env)
      @context = ctx
      @parameters = parms
      @environment = env
      @body = body
    end

    def call(*args)
      return context.eval(self.body, Crimson::Environment.new(
                            self.parameters, args, self.environment))
    end
  end
end
