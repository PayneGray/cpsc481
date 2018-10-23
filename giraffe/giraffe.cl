(defun giraffe ()

	(setq current-pos (cons 0 0))
	(setq closed-list (list current-pos))
    (setq open-list (list))

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

(defun possible-moves (current-pos)
        "Finds all legal moves from the current position and adds them to the open list"

        ; 1) clear the open list
        (setq open-list (list))
        ; 2) find possible moves and add them to open-list
        (loop for num from 0 to 11



do (if (and 
       (in-bound (+ (car current-pos) (aref move num 0)) (+ (cdr current-pos) (aref move num 1)))
       (not-visited (+ (car current-pos) (aref move num 0)) (+ (cdr current-pos) (aref move num 1)))
      )

      (setq open-list (append open-list (list (cons (+ (car current-pos) (aref move num 0)) 
                                                    (+ (cdr current-pos) (aref move num 1)))))
      )

      NIL
  )
                 
        )
    )


	(defun heuristic (open-list)
            "Chooses the best position from the open list to move to.
             Returns the position that the giraffe should move to as a cons cell"
        (car open-list)
    )



    (loop for num from 0 to 48
        do (terpri)
        do (format t "Current Position: ~a" current-pos)
        do (terpri)
        do (possible-moves current-pos)
        do (format t "Available Moves: ~a " open-list)
        do (terpri)
        do (setq next-pos (heuristic open-list))
        do (format t "Moving to: ~a " next-pos)
        do (terpri)
        do (move-to next-pos)

    )

	(format t "Path: ~a" closed-list)

)
(giraffe)