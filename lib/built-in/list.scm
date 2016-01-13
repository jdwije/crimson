;; A collection of generic list operations

;; Takes a function and a list as arguments then interates the list mapping
;; the function to each element in it.
(define map
  (lambda (f lis)
    (cond ((null? lis) nil)
          (else (cons (f (car lis))
                      (map f (cdr lis)))
           )
    )
  )
)

;; Takes an expression +ele+ and a list +lis+ as arguments then iterates the
;; list checking to see if the element exits in the list, returning #t or #f
;; based of the outcome.
(define exists-in?
  (lambda (ele lis)
    (cond ((null? lis) #f)
          ((equal? ele (car lis)) #t)
          (else (exists-in? ele (cdr lis)))
    )
  )
)
