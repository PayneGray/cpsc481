; CPSC 481 - Artificial Intelligence
; Team: Chantalle Bril, Payne Lacsamana, Abdul Dergham, Luis Rangel

;========== GLOBAL VARIABLESS ==========;
;Please declare global vars in here
;Beware when using setq - you might be setting a global variable when a local variable is needed

; Our list of all ants
(defvar ants (list))

; The number of ants that have found the goal
(defvar num-ants-found-goal 0)

; The shortest path to the goal
(defvar shortest-path (list))

; The grid the ants will traverse
; -1.0 means there is an obstacle on the cell
; 0 means the cell is clear
; Positive values mean there is pheromone on the cell
(aref (setq grid (make-array '(40 60) 
                    :element-type 'single-float
                    :initial-contents '((0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0)
(0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  0.0  -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0)
(0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   0.0  -1.0   -1.0   0.0  -1.0   -1.0   -1.0   -1.0   -1.0   0.0  0.0  -1.0   -1.0   0.0  0.0  -1.0   -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   -1.0    -1.0)
(0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   -1.0   -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   0.0  0.0)
(0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   -1.0   -1.0   -1.0   0.0  0.0  -1.0   -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   -1.0   -1.0   0.0  0.0  -1.0   -1.0   0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0)
(0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   -1.0   -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0)
(0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   -1.0   -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0)
(0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   -1.0   -1.0   -1.0   0.0  -1.0   0.0)
(0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   -1.0   0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0)
(-1.0    -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   0.0  -1.0   -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   -1.0   -1.0   0.0  -1.0   0.0  -1.0   0.0  -1.0   0.0  0.0)
(0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   -1.0   0.0  -1.0   0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   -1.0   0.0  0.0  -1.0   -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0)
(0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0 )
(0.0  0.0  0.0  -1.0   -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   -1.0   0.0  0.0   -1.0)
(0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   0.0  -1.0   -1.0   -1.0   -1.0   0.0  -1.0   0.0  -1.0   -1.0   -1.0   -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0)
(0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   -1.0   -1.0   0.0  -1.0   -1.0   0.0)
(-1.0    -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   -1.0   -1.0   0.0  0.0  0.0  0.0  0.0  0.0 )
(0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0)
(0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   0.0  -1.0   0.0  -1.0   -1.0   0.0  -1.0    -1.0)
(0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   -1.0   -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0)
(0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0 )
(0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0)
(0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   -1.0   -1.0   0.0  -1.0   0.0   -1.0)
(0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   0.0  -1.0   -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0)
(0.0  -1.0   -1.0   0.0  -1.0   -1.0   -1.0   -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0 )
(0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   -1.0   -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0 )
(0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0)
(0.0  0.0  -1.0   0.0  -1.0   -1.0   -1.0   0.0  -1.0   0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   -1.0   -1.0   0.0  -1.0 )
(0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   0.0  -1.0   -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0)
(0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   -1.0   -1.0   -1.0   -1.0   0.0  0.0 )
(0.0  0.0  0.0  0.0  -1.0   -1.0   0.0  -1.0   0.0  -1.0   -1.0   0.0  -1.0   -1.0   0.0  -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   -1.0   0.0  -1.0   0.0  0.0  -1.0   -1.0   -1.0   -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0)
(-1.0    -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0)
(0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0)
(-1.0    0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   0.0  -1.0   0.0  -1.0   -1.0  )
(0.0  0.0  0.0  0.0  -1.0   -1.0   -1.0   -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   -1.0   0.0  -1.0   0.0  -1.0   -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0)
(0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0)
(0.0  -1.0   -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   -1.0   -1.0   -1.0   -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   -1.0   -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   -1.0   -1.0   0.0)
(0.0  0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0)
(0.0  0.0  -1.0   -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  -1.0   0.0  -1.0   0.0  -1.0   0.0  0.0  -1.0   -1.0   -1.0   0.0)
(0.0  0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   -1.0   0.0  0.0  0.0  0.0  0.0  0.0)
(0.0  0.0  0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  -1.0   0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0  0.0))))
        1 2)
;=======================================;

;========== FUNCTIONS ==========;

(defun spawn-ant ()
	; add documentation here
	(setq ants (append ants
		(list (list '(0 0) nil (list '(0 0)) (list '(0 0))))
	)) 
)

;adds 20 to everything for testing
(loop for i from 0 to 39
	do(loop for j from 0 to 59
		do (if (= (aref grid i j) 0.0)
			(setf (aref grid i j) (+ (aref grid i j) 20))
			)
	)
)

(defun evaporate-scent ()
	; add documentation here
	(loop for i from 0 to 39
		do(loop for j from 0 to 59
			do (if (> (aref grid i j) 0.0)
				(progn
					(setf (aref grid i j) (- (aref grid i j) (* (aref grid i j) 0.01)))
				)
			)
		)
	)

)


(defun Migrate-scent (a b) 

"grabs 1% of the current gas"
(setq gas (float(/ (aref grid a b) 500)))

"checks to see if left cell exists and if it does the gas moves over if no wall exists"
(if (> (- a 1) -1) (if (> (aref grid (- a 1) b) -1) (setf (aref grid (- a 1) b) (+ (aref grid (- a 1) b) gas))))

"checks to see if right cell exists and if it does the gas moves over if no wall exists"
(if (< (+ a 1) 41) (if (> (aref grid (+ a 1) b) -1) (setf (aref grid (+ a 1) b) (+ (aref grid (+ a 1) b) gas))))

"checks to see if top cell exists and if it does the gas moves over if no wall exists"
(if (> (- b 1) -1) (if (> (aref grid a (- b 1)) -1) (setf (aref grid a (- b 1)) (+ (aref grid a (- b 1)) gas))))

"checks to see if bottom cell exists and if it does the gas moves over if no wall exists"
(if (< (+ b 1) 61) (if (> (aref grid a (+ b 1)) -1) (setf (aref grid a (+ b 1)) (+ (aref grid a (+ b 1)) gas))))

)

;===============================;

;========== MAIN ==========;

(loop while (< num-ants-found-goal 30)
	do

;	(if (eq nil (cdr ants))
;		(setq ants (car ants))
;	)

	(loop for i from 0 to (list-length ants)
		do

		( let ( (ant (nth i ants)) )
			(print ant)
		)
	)

	(spawn-ant)

	; Just so we don't have an infinite loop
	(setq num-ants-found-goal (+ 10 num-ants-found-goal))
)
;==========================;
