; TODO
; 1. Take a list, run it as an expression
; 2. take 2 lists, split and merge to one expression
; 3. random thing


; What needs to be done? 
; 1. Generate a 50 empty array
(setq x (- 9 (random 19)))
(setq y (- 9 (random 19)))
(setq z (- 9 (random 19)))

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




(defun generate-function ()
	(setf fun (make-array '(3)))
)
; 4. make a function that takes 2 functions, reads each as a list
; 5. 


; if statements? take the first element to either multiply, subtract, or add
; 

