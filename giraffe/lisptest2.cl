; Payne Lacsamana, Chantalle Bril, Bobby Dergham

; Please use descriptive variable and function names
; Please use a hyphens (-) as separators in variable and function names
;  (e.g. make-array current-pos etc.)

; ---------- GLOBAL VARIABLES ----------
; Current position is an (x,y) coordinate stored in a cons cell. It represents the current position of the giraffe on the board
;  - How to declare a cons cell: (setq position (cons x y))
;  - How to get x value from cons cell: (car position)
;  - How to get y value from cons cell: (cdr position)
(setq current-pos (cons 0 0))

; List of positions we have already visited. Positions are (x,y) coordinates stored in cons cells
(setq closed-list (list current-pos))
;(setq open-list '(list current-pos))

(setf move (make-array '(12 2) 
   :initial-contents '((1 0) (0 1) (-1 0) (0 -1) (1 2) (-1 2) (1 -2) (-1 -2) (2 1) (-2 1) (2 -1) (-2 -1) ))
)




; ---------- FUNCTION DEFINITIONS ----------

(defun move-to (pos)
	"Moves to the position and updates the current position to the position.
	 Position (pos) is a cons cell where x-coord = (car pos) and y-coord = (cdr pos)"
	(setq closed-list (append closed-list (list pos)))
	(setq current-pos pos)
)

(defun in-bound (a b) 
	"checks if new move is out of bounds"
	(and 
		(and (if (< a 7) 0 NIL) (if (> a -1) 0 NIL )) 
		(and (if (< b 7) 0 NIL) (if (> b -1) 0 NIL ))

	)
)

(defun not-visited (a b)
	"if position in the board has been stepped on, return 0, else return nil"
	(if (eql (aref board a b) 0) 0 NIL)
)

(setf moves '((0 0)))
(append moves '((1 1)))


(possible-moves (car current-pos) (cdr current-pos))


(defun possible-moves (x y)
	"Input: current x position, current y position
	 Populates all the legal moves from the current position and
	 adds them to the open list"
	(setq move-list (list))

	(loop for num from 0 to 11
		do (write 



(if 
	(and 
		(in-bound (+ x (aref move num 0)) (+ y (aref move num 1))) 
		(not-visited (+ x (aref move num 0)) (+ y (aref move num 1)))) 
			(setq move-list (append move-list '(((+ x (aref move num 0)) (+ y (aref move num 1))))))		 
			NIL


))



	)
)
(defun giraffe ()
	 (loop for num from 0 to 20
	do ;this stuff
	)

)

