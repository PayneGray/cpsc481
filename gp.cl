; What needs to be done? 
; 1. Generate a 50 empty array
(defvar x 1)
(defvar y 1)
(defvar z 1)
(setf population (make-array '(50)))

; 2. Be able to fill it, maybe just with (+ 1 1)
(loop for n from 0 to 49
   do (setf (aref population n) (* x))
)
(write population)
; 3. read a list as an expression
(setf fun (make-array '(3)))
(setf (aref fun 0) '*)
(setf (aref fun 1) 2)
(setf (aref fun 2) 3)


; 4. make a function that takes 2 functions, reads each as a list
; 5. 


; if statements? take the first element to either multiply, subtract, or add
