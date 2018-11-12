; TODO
; 1. Take a list, run it as an expression
; 2. take 2 lists, split and merge to one expression
; 3. random thing


; What needs to be done? 
; 1. Generate a 50 empty array
; (setq x (- 9 (random 19)))
; (setq y (- 9 (random 19)))
; (setq z (- 9 (random 19)))

; ================================= GLOBAL VARIABLES ========================================

; Alphabet of operands and operators
(setq all-consts (list -9 -8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9))
(setq all-vars (list 'x 'y 'z))
(setq all-ops (list '+ '- '*))

; ================================= MAIN FUNCTION ===========================================

(setf population (list))

(loop for n from 0 to 49
   do (setf population (append population (list (generate-expression 0))))
)
(loop for i from 0 to 49
  do (print (nth i population)))

(setf new-population (list))

(loop for i from 0 to 24
  do (print "parents:")a
  do (print (nth (* i 2) population))
  do (print (nth (+ 1 (* i 2)) population))
  do (terpri)
  do (setf new-population (append new-population (list (crossed-kid (nth (* i 2) population) (nth (+ 1 (* i 2)) population)))))
  do (setf new-population (append new-population (list (crossed-kid (nth (* i 2) population) (nth (+ 1 (* i 2)) population)))))
  do (print "kids:")
  do (print (nth (* i 2) new-population))
  do (print (nth (+ 1 (* i 2)) new-population))
  do (terpri)
)

(loop for i from 0 to 49
  
  do (print (nth i new-population)))

;fitness testing
; all wrong, replace later
(setf best-fit (nth 0 population))
(loop for i from 1 to 49
    do (print (eval (nth i population)))
    do (if (< (eval best-fit) (eval (nth i population)))
        (setf best-fit (nth i population))
    )
)
(eval best-fit)
; ================================= FUNCTIONS ===============================================



(defun crossed-kid (expr1 expr2)
  (setf kid (list))
  (setf ops (list (nth 0 expr1) (nth 0 expr2)))
  (setf kid (append kid (list (nth (random 2) ops))))
  ;takes random part of expr1 and appends it to kid
  (setf kid (append kid (list (nth (+ 1 (random 2)) expr1))))
  ;takes random part of expr2 and appends it to kid
  (setf kid (append kid (list (nth (+ 1 (random 2)) expr2))))
)
; To use:
; (setf expr '(+ (+ (+ 4 -9) 6) (+ (- (* (- z 6) 2) 9) x)))
; (crossed-kid expr expr)
; (eval (crossed-kid expr expr))


(defun generate-expression (num-sub-exprs)
  "Generates a random expression with one operator and two operands. Only call this function with
   an argument of 0. Operators may be +, -, or *. Operands may be constant integers between -9 and
   9 or variables x, y, or z. Operands may also be sub-expressions. The expression returned by
   this function may not contain an operand with more than 3 sub-expressions."
  (let (
        (operator (nth (random (list-length all-ops)) all-ops))
        (operands (list))
       )
    ; There is an equal probability of the operand being a variable, a constant, or an expression.
    (if (<= num-sub-exprs 3) 
      (progn 
        (setq prob-var 0)
        (setq prob-const 33)
        (setq prob-expr 66)
      )
    ; If there are more than 3 sub-expressions in this operand, there is no probability of the
    ; operand being an expression and equal probability of the operand being a variable or a
    ; constant.
      (progn
        (setq prob-var 0)
        (setq prob-const 50)
        (setq prob-expr 100)
      )
    )
    ; Select 2 random operators
    (loop for i from 0 to 1
      do
      (progn
        (setq rando (+ (random 100) 1))
        (cond
          ((> rando prob-expr) 
            (progn
              (setq sub-exprs (+ num-sub-exprs 1))
              (setq operand (generate-expression sub-exprs))
            )
          )
          ((> rando prob-const) 
            (setq operand (nth (random (list-length all-consts)) all-consts))
          )
          ((> rando prob-var) 
            (setq operand (nth (random (list-length all-vars)) all-vars))
          )
        )
        (setq operands (append operands (list operand)))
      )
    )
    (setq expression (append (list operator) operands))
  )
  (return-from generate-expression expression)
)
