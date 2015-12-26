class Symbol

  attribute_getter :string

  def initialize(str)
    string(str)
  end

  def Sym(s, symbol_table={})
    symbol_table[s] = Symbol(s) unless symbol_table.contains?(s)

    symbol_table[s]
  end

  _quote, _if, _set, _define, _lambda, _begin, _definemacro, = map(Symbol,
  "quote   if   set!  define   lambda   begin   define-macro".split)

  _quasiquote, _unquote, _unquotesplicing = map(Symbol,
  "quasiquote   unquote   unquote-splicing".split)

end
