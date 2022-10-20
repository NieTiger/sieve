(declaim (optimize (speed 2) (safety 0)))

(load "sieve.lisp")

(defun load-file (fname)
  (with-open-file (stream fname)
    (loop for x = (read stream nil)
          while x
            collect x)))

(defun compare-lists (l1 l2)
  (assert (eql (length l1) (length l2))
          (l1 l2)
          "List have different lengths.")
  (loop for x1 in l1
        for x2 in l2
        do (assert (eql x1 x2)))
  t)

; load truth file and check results
(defvar truth (load-file "../truth.txt"))
(defvar res (sieve 1000000))
(compare-lists truth res)


(defun main ()
  (do ((end (+ (get-internal-real-time) (* 5 internal-time-units-per-second)))
       (passes 0 (+ 1 passes)))
      ((> (get-internal-real-time) end)
       (format t "~a~%" passes))
    (declare (type (unsigned-byte 64) passes)
             (type (unsigned-byte 64) end))
    (sieve 1000000)))

; (main)
 (save-lisp-and-die "sieve" :executable t :toplevel #'main)
