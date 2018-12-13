;!!!! DELETE DEBUG CODE BEFORE SUBMIT !!!!!
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

; Number of iterations / moves until program reached the end
(defvar iterations 0)

; All paths from start to goal
(defvar all-paths (list))

; The grid the ants will traverse
; -1.0 means there is an obstacle on the cell
; 0 means the cell is clear
; Positive values mean there is pheromone on the cell
(aref (setq grid (make-array '(40 60) 
                    :element-type 'single-float
                    :initial-contents '(( 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0)
( 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 -1.0  -1.0  -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 -1.0  -1.0  0.0 -1.0  -1.0  -1.0  -1.0  0.0 -1.0  -1.0  0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 0.0)
( 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  -1.0  0.0 -1.0  0.0 -1.0  -1.0  0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 0.0)
( 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 -1.0  -1.0  -1.0  0.0 -1.0  -1.0  0.0 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 0.0 0.0 0.0 -1.0  -1.0  -1.0  0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)
( 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 -1.0  -1.0  -1.0  -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 0.0)
( 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 -1.0  -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  -1.0  -1.0  -1.0  0.0 0.0 -1.0  -1.0  -1.0  0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 0.0)
( 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 -1.0  -1.0  -1.0  -1.0  0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 0.0)
( 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  -1.0  -1.0  0.0 0.0 -1.0  -1.0  0.0 0.0 0.0 0.0 0.0 -1.0  -1.0  0.0 -1.0  0.0 -1.0  -1.0  -1.0  0.0 -1.0  -1.0  0.0 0.0 -1.0  0.0 0.0 0.0)
( -1.0  -1.0  0.0 0.0 -1.0  -1.0  0.0 -1.0  0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)
( 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0)
( 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  -1.0  -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  -1.0  -1.0  0.0 -1.0  -1.0  0.0 -1.0  0.0 -1.0  -1.0  -1.0  0.0 -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  0.0 -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  0.0 -1.0  -1.0  -1.0  -1.0  -1.0  0.0 0.0 -1.0  0.0 0.0 0.0)
( 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0)
( -1.0  -1.0  0.0 -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  0.0 -1.0 )
( 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)
( 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0)
( 0.0 0.0 -1.0  -1.0  0.0 0.0 -1.0  -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  -1.0  0.0 0.0 -1.0  -1.0  -1.0  -1.0  -1.0  0.0 -1.0  -1.0  -1.0  -1.0  0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 -1.0  -1.0  -1.0  0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0)
( 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  -1.0  -1.0  0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 0.0)
( 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 0.0 0.0 0.0 -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  0.0 -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  0.0 -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0 )
( 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)
( 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 -1.0  -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  -1.0  -1.0  -1.0  0.0 0.0 -1.0  -1.0  -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)
( 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 -1.0  0.0 -1.0  0.0 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 -1.0  -1.0  -1.0  0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  0.0 -1.0  -1.0  -1.0  -1.0  -1.0  0.0 -1.0  -1.0  -1.0  -1.0 )
( 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)
( -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  0.0 -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)
( 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  -1.0  -1.0  -1.0  0.0 0.0 -1.0  -1.0  0.0 -1.0  -1.0  0.0 -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0 )
( 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 -1.0  0.0 -1.0  0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  -1.0  0.0 0.0 -1.0  -1.0  -1.0  0.0 -1.0  -1.0  0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0)
( 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0)
( 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 -1.0  -1.0  0.0 0.0 -1.0  -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)
( -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  0.0 0.0 -1.0  -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 0.0)
( 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  -1.0  -1.0  -1.0  0.0 -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  0.0 -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0 )
( 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0)
( 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  -1.0  -1.0  -1.0  0.0 -1.0  -1.0  -1.0  -1.0  0.0 -1.0  -1.0  -1.0  -1.0  -1.0  0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  -1.0  -1.0  -1.0  -1.0  0.0 -1.0  -1.0  0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  -1.0  0.0 -1.0  0.0 -1.0 )
( 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0)
( 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  -1.0  0.0 -1.0  0.0 -1.0  -1.0  0.0 -1.0  -1.0  0.0 -1.0  0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 -1.0  -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 -1.0  0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0)
( 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 -1.0  -1.0  -1.0  -1.0  0.0 -1.0  0.0 -1.0  0.0 -1.0  0.0 -1.0  0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0)
( 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 -1.0  0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0)
( 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  0.0 -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 -1.0  0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0)
( 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0)
( 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 0.0 -1.0  -1.0  -1.0  -1.0  0.0 -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  -1.0  0.0 -1.0  -1.0  0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0)
( 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 -1.0  0.0 0.0 -1.0  0.0 0.0)
( 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 -1.0  0.0 0.0 -1.0  0.0 0.0 0.0 0.0 0.0 0.0 -1.0  0.0 0.0))))
        1 2)
;=======================================;

;========== FUNCTIONS ==========;

(defun spawn-ant ()
	; add documentation here
	(setq ants (append ants
		(list (list (list 0 0) nil (list (list 0 0)) (list (list 0 0))))
	)) 
)

;adds 20 to half the grid for testing
(defun test ()
	(loop for i from 0 to 19
		do(loop for j from 0 to 59
			do (if (= (aref grid i j) 0.0)
				(setf (aref grid i j) (+ (aref grid i j) 20))
				)
		)
	)
)


(defun migrate-scent (a b) 
	;documentation here
	"grabs 1% of the current gas"
	(setq gas (float(/ (aref grid a b) 500)))

	"checks to see if left cell exists and if it does the gas moves over if no wall exists"
	(if (> (- a 1) -1) 
		(if (> (aref grid (- a 1) b) -1) 
			(setf (aref grid (- a 1) b) (+ (aref grid (- a 1) b) gas))))

	"checks to see if right cell exists and if it does the gas moves over if no wall exists"
	(if (< (+ a 1) 40) 
		(if (> (aref grid (+ a 1) b) -1) 
			(setf (aref grid (+ a 1) b) (+ (aref grid (+ a 1) b) gas))))

	"checks to see if top cell exists and if it does the gas moves over if no wall exists"
	(if (> (- b 1) -1) (if (> (aref grid a (- b 1)) -1) (setf (aref grid a (- b 1)) (+ (aref grid a (- b 1)) gas))))

	"checks to see if bottom cell exists and if it does the gas moves over if no wall exists"
	(if (< (+ b 1) 60) (if (> (aref grid a (+ b 1)) -1) (setf (aref grid a (+ b 1)) (+ (aref grid a (+ b 1)) gas))))
)

(defun evaporate-scent ()
	; add documentation here
	(loop for i from 0 to 39
		do(loop for j from 0 to 59
			do (if (> (aref grid i j) 0.0)
				(progn
					(migrate-scent i j)
					;maybe make to 0 if it's less than 0
					(setf (aref grid i j) (- (aref grid i j) (* (aref grid i j) 0.01)))
				)
			)
		)
	)

)


(setq test-ant (list (list 0 1) nil (list (list 0 0) (list 0 1)) (list (list 0 0) (list 0 1))))

(setq test-ant2 (list (list 0 1) nil (list (list 0 1) ) (list (list 0 0) (list 0 1))))

(defun is-in (elem arr)
	; if element is in array, return 1
	; else, return nil
	(setf true nil)
	(loop for i in arr
		do (if (and (= (nth 0 elem) (nth 0 i)) (= (nth 1 elem) (nth 1 i)))
			(setf true 1)
			)
	)
	(return-from is-in true)
)

(defun open-list (ant)
	"add documentation here"
	(setf arr (list))
	(setf row (nth 0 (nth 0 ant)))
	(setf col (nth 1 (nth 0 ant)))
	(setf tabu (nth 2 ant))

	(if (< (+ row 1) 39.0) ;row is less than 39, can move down
		(if (/= -1.0 (aref grid (+ row 1) col))
			(if (not (is-in (list (+ row 1) col) tabu))
				(setf arr (append arr (list (list (+ row 1) col)))) 
			)
		)
	)
	(if (> (- row 1) -1.0) ;row is more than 0, can move up
		(if (/= -1.0 (aref grid (- row 1) col))
			(if (not (is-in (list (- row 1) col) tabu))
				(setf arr (append arr (list (list (- row 1) col)))) 
			)
		)
	)
	(if (< (+ col 1) 59.0) ;col is less than 59, can move right
		(if (/= -1.0 (aref grid row (+ col 1)))
			(if (not (is-in (list row (+ col 1)) tabu))
				(setf arr (append arr (list (list row (+ col 1))))) 
			)
		)
	)
	(if (> (- col 1) -1.0) ; col is more than 0, can move left
		(if (/= -1.0 (aref grid row (- col 1)))
			(if (not (is-in (list row (- col 1)) tabu))
				(setf arr (append arr (list (list row (- col 1))))) 
			)
		)
	)

	(return-from open-list arr)
)

(defun at-start (ant)
	"Returns T if the ant at the given index is at the start position, or NIL otherwise"
	(if (equal (car ant) (list 0 0))
		(return-from at-start T)
		(return-from at-start NIL)
	)
)

(defun at-goal (ant)
	"Returns T if the ant at the given index is at the goal position, or NIL otherwise"
	(if (equal (car ant) (list 39 59))
		(return-from at-goal T)
		(return-from at-goal NIL)
	)
)

(defun clear-tabu (ant-index)
    "Resets the ant's tabu list to contain only its current position"
    (setq tabu (list (list(car (nth ant-index ants)))))
    (replace (nth ant-index ants) tabu :start1 2 :end1 3)
)

(defun without-last(l)
	"Return list without last element"
    (reverse (cdr (reverse l)))
)

(defun trim-tabu (ant-index)
	"Make sure the tabu list is not longer than 8 cells long"
	(let ((tabu (nth 2 (nth ant-index ants))))
		(if (> (list-length tabu) 7)
			(progn
				(setq new-tabu (without-last tabu))
				(replace (nth ant-index ants) (list new-tabu) :start1 2 :end1 3)
			)
		)
	)
)

(defun drop-scent (ant)
  "Drops a scent value of 10 at given ant's cell location."
  (progn
    (setq x (car (nth 0 ant)))
    (setq y (car (cdr (nth 0 ant))))
    (setf (aref grid x y) (+ (aref grid x y) 10))
  )
)

(defun mode-direction (ant a b)
	"If the ant is foraging, it prefers to move to the bottom right.
	 If the ant is returning, it prefers to move to the top left.
	 Returns the sum difference between the coordinates of the ant and the grid location coordinates.
	 When foraging, ant prefers a positive difference.
	 When returning, ant prefers a negative difference."
	 (let ( (x (car (car ant))) (y (car(cdr (car ant)))) )
	 	(setq diff (+ (- a x) (- b y)))
	 	(if (nth 1 ant)
	 		; If ant is returning, return inverse of diff
	 		(return-from mode-direction (float (* -1 diff)))
	 		; If ant is foraging, just return diff
	 		(return-from mode-direction (float diff))
	 	)
	 )
)

(defun rand-fuzz ()
	"Returns a random number between -.8 and .8"
	(return-from rand-fuzz (float (/ (- (random 161) 80) 100.0)))
)

(defun heuristic (ant a b)
	"Determines the heuristic value for the ant to move to the grid location at (a b).
	 Heuristic is a non-negative float value. Higher values imply higher favorability"
	 (setq fuzz (rand-fuzz))
	 ;(setq heur (+ (mode-direction ant a b) (* (aref grid a b) 0.1) fuzz) )
	 (setq heur (+ (* (aref grid a b) 0.1) fuzz) )
	 (return-from heuristic (float heur))
)

(defun move (ant-index)
	"Moves the ant to the best cell possible"
	(let ((ant (nth ant-index ants)))
		;(format t "  Moving ant ~D :~S~%" ant-index ant)

		;===== Drop scent if returning
		(if (nth 1 ant)
			(drop-scent ant)
			;(format t "  ant is foraging!~%")
		)

		;===== Get the open list
		(setq open-cells (open-list ant))

		;===== If open list is empty, clear tabu and do it again
		(if (not open-cells)
			(progn 
				(clear-tabu ant-index)
				(setq open-cells (open-list ant))
				;(format t "!!! Cleared the tabu list !!!")
			)
		)

		;(format t "  Open list: ~S~%" open-cells)

		;===== Call the heuristic on each cell
		;best-cell is cell with highest heuristic
		(setq best-cell (car open-cells))
		(setq best-heuristic 0)
		(loop for i from 0 to (- (list-length open-cells) 1)
			do
			(let ((cell (nth i open-cells)))
				;(format t "    Evaluating cell: ~S~%" cell)
				(setq heur (heuristic ant (nth 0 cell) (nth 1 cell)))
				;(format t "    Cell ~S has heuristic ~D~%" cell heur)
				(if (> heur best-heuristic)
					(progn
						(setq best-cell cell)
						(setq best-heuristic heur)
					)
				)
			)
		)
		;(format t "  Moving to best cell: ~S~%" best-cell)
		(replace (nth ant-index ants) (list best-cell) :start1 0 :end1 1)
		;===== Add to tabu
		(replace (nth ant-index ants) (list (push best-cell (nth 2 ant))) :start1 2 :end1 3)
		(trim-tabu ant-index)
		;===== Add to closed
		(replace (nth ant-index ants) (list (append (nth 3 ant) (list best-cell))) :start1 3 :end1 4)
	)
)

(defun get-shortest-path ()
	"Returns the path from all-paths which is the shortest"
  (loop for i from 0 to (- (list-length all-paths) 1)
    do
    (if (not shortest-path)
      (setq shortest-path (nth i all-paths))
    )
    (if (< (list-length (nth i  all-paths)) (list-length shortest-path))
      (setq shortest-path (nth i all-paths))
    )
  )
)

;===============================;

;========== MAIN ==========;
(loop while (< num-ants-found-goal 15000)
	do
		;(format t "========== Iteration ~D ==========~%" iterations)
		(setq iterations (+ 1 iterations))

	(loop for i from 0 to (- (list-length ants) 1)
		do
		( let ( (ant (nth i ants)) )
			(if ant
			(progn
				;(format t "~%----- Ant ~D -----~%~S~%" i ant)
				(move i)

				; If ant is foraging and found the goal
				(if (and (at-goal ant) (not (nth 1 ant)))
					(progn
						(print "@@@ !FOUND FOOD! !PARTY! @@@")
						(setq num-ants-found-goal (+ num-ants-found-goal 1))
						(setq all-paths (append all-paths (list (nth 3 ant))))
						; Ant switches to returning mode
						(replace (nth i ants) (list t) :start1 1 :end1 2)
					)
				)

				; If ant is returning and found the start
				(if (and (at-start ant) (nth 1 ant))
					(progn
						(format t "!!! This ant is at the colony !!!~%")
						(replace ants (list nil) :start1 i :end1 (+ i 1))
					)
				)
			))
		)
	)
    (evaporate-scent)
    ;makes sure theres never more than 50 ants
    ; !!!!! CHANGE 3 TO 50 !!!!!!!
	(if (< (list-length ants) 10) (spawn-ant))
	

	; Just so we don't have an infinite loop
	; !!!!! DELETE ME BEFORE SUBMIT!!!! VVV
	(setq num-ants-found-goal (+ 1 num-ants-found-goal))
)

(get-shortest-path)
(format t "Shortest path: ~S~%" shortest-path)

(format t "Final ant check at iteration ~D~%" iterations)
(loop for i from 0 to (- (list-length ants) 1)
	do
	(let ((ant (nth i ants)))
		(format t "Ant ~D : ~S~%  ~S~%" i (car ant) (nth 2 ant))
	)
)
;==========================;

