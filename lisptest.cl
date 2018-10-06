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
(setq closed-list '(list current-pos))
;(setq open-list '(list current-pos))

; ---------- FUNCTION DEFINITIONS ----------

(defun move-to (pos)
"Moves to the position and updates the current position to the position.
 Position (pos) is a cons cell where x-coord = (car pos) and y-coord = (cdr pos)"
(setq closed-list (append closed-list list(pos)))
(setq current-pos pos)
)


"Returns true if moving to the position is a legal move,
 Returns false if moving to the position is illegal."
(defun legal-move (pos))

;(setf board (make-array '(7 7)))  ; Bobby and I realized that there is no need for a board array if we use a closed list instead
(setf move (make-array '(12 2) 
   :initial-contents '((1 0) (0 1) (-1 0) (0 -1) (1 2) (-1 2) (1 -2) (-1 -2) (2 1) (-2 1) (2 -1) (-2 -1) ))
)


; Starting Position
;(setq x 0)
;(setq y 0)

; set starting position value 1
(setf (aref board x y) 1)


;checks if new move is out of bounds
(defun in-bound (a b) 
	(and 
		(and (if (< a 7) 0 NIL) (if (> a -1) 0 NIL )) 
		(and (if (< b 7) 0 NIL) (if (> b -1) 0 NIL ))
	)
)

(defun not-visited (a b)
	"if position in the board has been stepped on, return 0, else return nil"
	(if (eql (aref board a b) 0) 0 NIL)
)


;(and (valid a b) (steppable a b))

(setf moves '((0 0)))
(append moves '((1 1)))


(possible-moves (car current-pos) (cdr current-pos))
(defun possible-moves (x y)
	"Input: current x position, current y position
	 Populates all the legal moves from the current position and
	 adds them to the open list"
	;make a list
	;append
	
	(loop for num from 0 to 11
		do (write 
(if 
	(and 
		(in-bound (+ x (aref move num 0)) (+ y (aref move num 1))) 
		(not-visited (+ x (aref move num 0)) (+ y (aref move num 1)))) 
			;add to open-list			 
			NIL


))
      ;do (write (valid (+ x (aref move num 0)) (+ y (aref move num 1))))
      ;do (terpri)
	)
)


;(aref moves 0 0) ; add to new x 
;(aref moves 0 1) ; add to new y
;(defun step (a x y)
;	((setf x (+ (aref move a 0) x))	(setf y (+ (aref move a 1) y)))
;)

