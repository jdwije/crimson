module Risp
  STD_ENVIRONMENT = {
    '+'=>op.add, '-'=>op.sub, '*'=>op.mul, '/'=>op.div,
    '>'=>op.gt, '<'=>op.lt, '>='=>op.ge, '<='=>op.le, '='=>op.eq,
    'abs'=>     abs,
    'append'=>  op.add,
    'apply'=>   apply,
    'begin'=>   lambda { |*x| x[-1] },
    'car' =>     lambda { |x| x[0] },
    'cdr'=>     lambda { |x| x[1:] },
    'cons'=>    lambda x,y=> [x] + y,
                       'eq?'=>     op.is_, 
        'equal?'=>  op.eq, 
        'length'=>  len, 
        'list'=>    lambda *x=> list(x), 
        'list?'=>   lambda x=> isinstance(x,list), 
        'map'=>     map,
        'max'=>     max,
        'min'=>     min,
        'not'=>     op.not_,
        'null?'=>   lambda x=> x == [], 
        'number?'=> lambda x=> isinstance(x, Number),   
        'procedure?'=> callable,
        'round'=>   round,
        'symbol?'=> lambda x=> isinstance(x, Symbol)
  }
end
