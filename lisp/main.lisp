(declaim (optimize (speed 2) (safety 0)))
(load "sieve.lisp")

(defun bench ()
  (do ((end (+ (get-internal-real-time) (* 5 internal-time-units-per-second)))
       (passes 0 (1+ passes)))
      ((> (get-internal-real-time) end)
       passes)
      (sieve 1000000)))

(defun main ()
  (write (bench))
  (terpri))

(save-lisp-and-die "sieve" :executable t :toplevel #'main)
