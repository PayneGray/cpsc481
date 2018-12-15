; CPSC 481 - Artificial Intelligence
; Team: Chantalle Bril, Payne Lacsamana, Abdul Dergham, Luis Rangel

;========== GLOBAL VARIABLESS ==========;

; Our list of all ants
(defvar ants (list))

; The number of ants that have found the goal
(defvar num-ants-found-goal 0)

; All paths from the start to the goal
(defvar all-paths (list))

; The shortest path from the start to the goal
(defvar shortest-path (list))

(defvar iterations 0)

; This is grid-d from the sample grids
;   x : -1.0
;   - : 0.0
(defvar grid)
(aref (setq grid (make-array '(40 60) 
                    :element-type 'single-float
                    :initial-contents '(( 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 -1.0 -1.0 -1.0 0.0 0.0 -1.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 -1.0 0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0)
( 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 -1.0 0.0 -1.0 -1.0 -1.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0)
( -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 0.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 0.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 -1.0 -1.0 -1.0 -1.0 0.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 0.0 -1.0 -1.0 -1.0 0.0 0.0)
( -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 0.0 -1.0 -1.0 -1.0 0.0 -1.0 -1.0 0.0 0.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 -1.0 -1.0 -1.0 -1.0 0.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 0.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 -1.0 -1.0 -1.0 -1.0 0.0 -1.0 0.0 -1.0 -1.0 0.0 0.0 0.0 -1.0 0.0 -1.0 -1.0 -1.0 0.0 0.0 0.0 -1.0 0.0 -1.0 0.0 -1.0 -1.0 -1.0 -1.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 -1.0 -1.0 -1.0 -1.0 0.0 -1.0 0.0 -1.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 -1.0 -1.0 -1.0 0.0 -1.0 0.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 -1.0 -1.0 0.0 -1.0 0.0 -1.0 -1.0 -1.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 -1.0 -1.0 -1.0 0.0 -1.0 -1.0 0.0 0.0 -1.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 -1.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 -1.0 -1.0 -1.0 -1.0 -1.0 0.0 -1.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 0.0 -1.0 -1.0 -1.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 -1.0 -1.0 0.0 0.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0)
( 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0)
( -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 0.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 0.0 -1.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 -1.0 -1.0 -1.0 0.0 0.0 -1.0 -1.0 -1.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 -1.0 -1.0 -1.0 -1.0 -1.0 0.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 0.0 -1.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0)
( -1.0 -1.0 -1.0 -1.0 -1.0 0.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 0.0 -1.0 -1.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 -1.0 0.0 -1.0 -1.0 -1.0 0.0 0.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 -1.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 -1.0 -1.0 -1.0 0.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 -1.0 -1.0 -1.0 0.0 -1.0 0.0 -1.0 -1.0 -1.0 0.0 0.0 -1.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0)
( 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 -1.0 0.0 -1.0 0.0 -1.0 -1.0 -1.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 -1.0 -1.0 -1.0 0.0 0.0 -1.0 -1.0 0.0 0.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 0.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 0.0 -1.0 -1.0 -1.0 -1.0 0.0 0.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 -1.0 -1.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 -1.0 -1.0 0.0 -1.0 -1.0 0.0 -1.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 -1.0 -1.0 -1.0 -1.0 0.0 -1.0 -1.0 -1.0 0.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 -1.0 -1.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 -1.0 -1.0 -1.0 -1.0 -1.0 0.0 0.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0)
( 0.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 -1.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0)
( 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 -1.0 0.0 0.0 -1.0 0.0 0.0))))
        1 2)

;========== FUNCTIONS ==========;

(defun spawn-ant ()
	; Creates a new ant at the start position and adds it to the list of ants
	(setq ants (append ants
		(list (list (list 0 0) nil (list (list 0 0)) (list (list 0 0))))
	))
)

(defun migrate-scent (a b) 
	" Takes 1% of the pheremone value of the cell at (a b) and distributes 1/5 of
	  it to the 4 surrounding cells of (a b)"

	(defparameter gas (float(/ (aref grid a b) 500)))
	; Prevent floating point underflow by preventing numbers from getting too small
	(if (< gas 0.01) (setq gas 0.0))

	(if (> (- a 1) -1) 
		(if (> (aref grid (- a 1) b) -1) 
			(setf (aref grid (- a 1) b) (+ (aref grid (- a 1) b) gas))))

	(if (< (+ a 1) 40) 
		(if (> (aref grid (+ a 1) b) -1) 
			(setf (aref grid (+ a 1) b) (+ (aref grid (+ a 1) b) gas))))

	(if (> (- b 1) -1) 
		(if (> (aref grid a (- b 1)) -1) 
			(setf (aref grid a (- b 1)) (+ (aref grid a (- b 1)) gas))))

	(if (< (+ b 1) 60) 
		(if (> (aref grid a (+ b 1)) -1) 
			(setf (aref grid a (+ b 1)) (+ (aref grid a (+ b 1)) gas))))
)

(defun evaporate-scent ()
	" The pheremone value of each cell on the board decreases by 1% "
	(loop for i from 0 to 39
		do(loop for j from 0 to 59
			do (if (> (aref grid i j) 0.0)
				(progn
					(migrate-scent i j)
					(setf (aref grid i j) (- (aref grid i j) (* (aref grid i j) 0.01)))
					; Prevent floating point underflow by preventing numbers from getting too small
					(if (< (aref grid i j) 0.01)
						(setf (aref grid i j) 0.0)
					)
				)
			)
		)
	)
)

(defun is-in (elem arr)
	" If the given element is in the given array, return 1
	  Otherwise, return nil"
	(defparameter true nil)
	(loop for i in arr
		do (if (and (= (nth 0 elem) (nth 0 i)) (= (nth 1 elem) (nth 1 i)))
			(setf true 1)
			)
	)
	(return-from is-in true)
)

(defun open-list (ant)
	"Returns a list of cell positions that the ant may move to from its current position.
	 The ant may not move into a cell that is off the grid, not a cell that contains an obstacle,
	 nor a cell that is in its tabu list."
	(defparameter arr (list))
	(defparameter row (nth 0 (nth 0 ant)))
	(defparameter col (nth 1 (nth 0 ant)))
	(defparameter tabu (nth 2 ant))

	(if (< (+ row 1) 40.0)
		(if (/= -1.0 (aref grid (+ row 1) col))
			(if (not (is-in (list (+ row 1) col) tabu))
				(setf arr (append arr (list (list (+ row 1) col)))) 
			)
		)
	)
	(if (> (- row 1) -1.0)
		(if (/= -1.0 (aref grid (- row 1) col))
			(if (not (is-in (list (- row 1) col) tabu))
				(setf arr (append arr (list (list (- row 1) col)))) 
			)
		)
	)
	(if (< (+ col 1) 60.0)
		(if (/= -1.0 (aref grid row (+ col 1)))
			(if (not (is-in (list row (+ col 1)) tabu))
				(setf arr (append arr (list (list row (+ col 1))))) 
			)
		)
	)
	(if (> (- col 1) -1.0)
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
    (defparameter tabu (list (list(car (nth ant-index ants)))))
    (replace (nth ant-index ants) tabu :start1 2 :end1 3)
)

(defun without-last(l)
	"Return list without its last element"
    (reverse (cdr (reverse l)))
)

(defun trim-tabu (ant-index)
	"Make sure the tabu list is not longer than 8 cells long. Remove the last element in the tabu "
	(let ((tabu (nth 2 (nth ant-index ants))))
		(if (> (list-length tabu) 8)
			(progn
				(defparameter new-tabu (without-last tabu))
				(replace (nth ant-index ants) (list new-tabu) :start1 2 :end1 3)
			)
		)
	)
)

(defun drop-scent (ant)
  "Drops a scent value of 10 at given ant's current cell location."
  (progn
    (defparameter x (car (nth 0 ant)))
    (defparameter y (car (cdr (nth 0 ant))))
    (setf (aref grid x y) (+ (aref grid x y) 10))
  )
)

(defun mode-direction (ant a b)
	 " Returns the sum difference between the coordinates of the ant and the grid location coordinates.
	   When foraging, ant prefers a positive difference.
	   When returning, ant prefers a negative difference."
	 (let ( (x (car (car ant))) (y (car(cdr (car ant)))) )
	 	(defparameter diff (+ (- a x) (- b y)))
	 	(if (nth 1 ant)
	 		(return-from mode-direction (float (* -1 diff)))
	 		(return-from mode-direction (float diff))
	 	)
	 )
)

(defun rand-fuzz ()
	"Returns a random number between -.8 and .8"
	(return-from rand-fuzz (float (/ (- (random 161 (make-random-state t)) 80) 100.0)))
)

(defun heuristic (ant a b)
	" Determines the heuristic value for the ant to move to the grid location at (a b).
	  Heuristic is a non-negative float value. Higher values imply higher favorability"
	 (defparameter fuzz (rand-fuzz))
	 ; If the ant is returning, it does not care about pheremones
	 (if (nth 1 ant)
	 	(defparameter heur (+ (mode-direction ant a b) fuzz))
	 	(defparameter heur (+ (mode-direction ant a b) (* (aref grid a b) 0.1) fuzz))
	 )
	 ;(defparameter heur (+ (mode-direction ant a b) (* (aref grid a b) 0.1) fuzz) )
	 ;(defparameter heur (+ (* (aref grid a b) 0.1) fuzz) )
	 (return-from heuristic (float heur))
)

(defun move (ant-index)
	"Moves the ant to the heuristically best cell. Drops pheremone if it is returning"
	(let ((ant (nth ant-index ants)))

		; Drop scent if returning
		(if (nth 1 ant)
			(drop-scent ant)
		)

		; Get all the possible cells the ant can move to
		(defparameter open-cells (open-list ant))
		(if (not open-cells)
			(progn 
				(clear-tabu ant-index)
				(setq open-cells (open-list ant))
			)
		)

		; Call the heuristic on each cell and select the cell with the highest heuristic
		(defparameter best-cell (car open-cells))
		(defparameter best-heuristic 0)
		(loop for i from 0 to (- (list-length open-cells) 1)
			do
			(let ((cell (nth i open-cells)))
				(defparameter heur (heuristic ant (nth 0 cell) (nth 1 cell)))
				(if (> heur best-heuristic)
					(progn
						(setq best-cell cell)
						(setq best-heuristic heur)
					)
				)
			)
		)
		; Update the ant's information
		(replace (nth ant-index ants) (list best-cell) :start1 0 :end1 1)
		(replace (nth ant-index ants) (list (push best-cell (nth 2 ant))) :start1 2 :end1 3)
		(trim-tabu ant-index)
		(replace (nth ant-index ants) (list (append (nth 3 ant) (list best-cell))) :start1 3 :end1 4)
	)
)

(defun get-shortest-path ()
	" Returns the path from all-paths which has the shortest length"
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


;========== MAIN ==========;
(loop while (< num-ants-found-goal 30)
	do
		(setq iterations (+ 1 iterations))

	(loop for i from 0 to (- (list-length ants) 1)
		do
		( let ( (ant (nth i ants)) )
			(if ant
			(progn
				(move i)

				(if (and (at-goal ant) (not (nth 1 ant)))
					(progn
						(setq num-ants-found-goal (+ num-ants-found-goal 1))
						(setq all-paths (push (nth 3 ant) all-paths))
						; The ant changes to "returning" mode
						(replace (nth i ants) (list t) :start1 1 :end1 2)
					)
				)

				(if (and (at-start ant) (nth 1 ant))
					(progn
						(replace ants (list nil) :start1 i :end1 (+ i 1))
					)
				)
			))
		)
	)
    (evaporate-scent)
	(if (and (= (mod iterations 10) 0) (< (list-length ants) 50)) (spawn-ant))
)

(format t "===== ~D ants found the goal =====~%" num-ants-found-goal)
(loop for i from 0 to (- (list-length all-paths) 1)
	do
	(format t "   Path ~D : Length ~D~%" i (list-length (nth i all-paths)))
)

(get-shortest-path)
(format t "===== Shortest path from start to goal =====~%   Length: ~D~%   ~S~%" (list-length shortest-path) shortest-path)


