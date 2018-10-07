(defun giraffe ()

	(setq current-pos (cons 0 0))
	(setq closed-list (list))
	(setq open-list (list current-pos))

	(setf move (make-array '(12 2) 
	   :initial-contents '((1 0) (0 1) (-1 0) (0 -1) (1 2) (-1 2) (1 -2) (-1 -2) (2 1) (-2 1) (2 -1) (-2 -1) ))
	)
	(defun move-to (pos)
		"Moves to the position and updates the current position to the position. Position (pos) is a cons cell where x-coord = (car pos) and y-coord = (cdr pos)"
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
    	"Input: x-coordinate of the position, y-coordinate of the position.
         If position has not been visited, return T.
         If position has been visited, return NIL."
	    (not 
	        (member (cons a b) closed-list :test #'equalp)
	    )
	)



	;(defun possible-moves (current-pos)
		; 1) clears the open list 
		; 2) finds possible moves 
		; 3) adds them to open list
	;)

	(loop for num from 0 to 20
		do (format t "Current Position: ~a" current-pos)
		do (terpri)
		do (possible-moves current-pos)
		do (format t "Available Moves: ~a " open-list)
		do (terpri)

	)

)
(giraffe)