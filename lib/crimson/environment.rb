module Crimson
  class Environment < Hash

    def initialize(keys=[], vals=[], outer=nil)
      @outer = outer
      if keys.is_a? Symbol
        puts 'mmot'
        [ keys ].zip(vals)
        store(keys, vals)
        # self.update({parms:list(args)})
        # keys.zip(vals.list).each{|p| store(*p)}
      else
        throw Exception, "expected #{keys.to_s} given #{vals.to_s}" unless keys.size == vals.size
        keys.zip(vals).each{|p| store(*p)}
      end
      ops = [:+, :-, :*, :/, :>, :<, :>=, :<=, :==]
      ops.each{ |op| self[op] = lambda{|a, b| a.send(op, b)} }
      self[:length] = lambda{ |x| x.length }
      self[:cons] = lambda{ |x, y| [x] + y }
      self[:car] = lambda{|x| x[0]}
      self[:cdr] = lambda{ |x| x[1..-1] }
      self[:append] = lambda{ |x,y| x + y }
      self[:list] = lambda{ |*xs| xs }
      self[:list?] = lambda{ |x| x.is_a? Array }
      self[:null?] = lambda{ |x| x == nil }
      self[:symbol?] = lambda{ |x| x.is_a? Symbol }
      self[:not] = lambda{ |x| !x }
      self[:display] = lambda{ |x| p x }
    end

    def [](name)  super(name) || @outer[name] end

    def set(name, value)
      key?(name) ? store(name, value) : @outer.set(name, value)
    end

  end
end
