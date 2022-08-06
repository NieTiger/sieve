(load "sieve")

(defun bench ()
  (do ((internal-duration (* 5 internal-time-units-per-second))
       (start (get-internal-real-time))
       (passes 0 (1+ passes)))
      ((> (- (get-internal-real-time) start) internal-duration)
       passes)
      (sieve 1000000)))

(write (bench))
(terpri)
