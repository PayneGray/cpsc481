(setf board (make-array '(7 7)))
(setf move (make-array '(12 2) 
   :initial-contents '((0 -1) (0 1) (1 2) (-1 2) (1 -2) (-1 -2) (2 1) (-2 1) (2 -1) (-2 -1) (1 0) (-1 0)))
)

; Starting Position
(setq x 0)
(setq y 0)

; set starting position value 1
(setf (aref board x y) 1)



(defun valid (a b) 
	"checks if new move is out of bounds"
	(and 
		(and (if (< a 7) 0 NIL) (if (> a -1) 0 NIL )) 
		(and (if (< b 7) 0 NIL) (if (> b -1) 0 NIL ))

	)
)

(defun steppable (a b)
	"if position in the board has been stepped on, return 0, else return nil"
	(if (eql (aref board a b) 0) 0 NIL)
)


(and (valid a b) (steppable a b))

(setf moves '((0 0)))
(append moves '((1 1)))

(defun pos-move (x y)
	;make a list
	;append
	(setf pos-moves '())
	(loop for num from 0 to 11
      do (write (valid (+ x (aref move num 0)) (+ y (aref move num 1))))
      do (terpri)
	)
)


;(aref moves 0 0) ; add to new x 
;(aref moves 0 1) ; add to new y
;(defun step (a x y)
;	((setf x (+ (aref move a 0) x))	(setf y (+ (aref move a 1) y)))
;)

