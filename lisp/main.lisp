(defun sieve (size)
  (if (< size 2)
      '()
      (let ((a (make-array size :initial-element 0))
            (res '(2)))
        (do ((q (sqrt size))
             (factor 3 (+ factor 2)))
            ((>= factor q)
             a)
            (progn 
              (setf factor 
                    (do ((i factor (+ i 2)))
                        ((or (zerop (aref a i)) (>= i size))
                         (if (< i size) i factor))))

              (do ((i (* factor 3) (+ i (* factor 2))))
                  ((>= i size) nil)
                  (setf (aref a i) 1))))

        (do ((i 3 (+ i 2)))
            ((>= i (- size 2)) (reverse res))
            (if (zerop (aref a i)) 
                (setf res (cons i res)))))))

(defun bench ()
  (do ((internal-duration (* 5 internal-time-units-per-second))
       (start (get-internal-real-time))
       (passes 0 (1+ passes)))
      ((> (- (get-internal-real-time) start) internal-duration)
       passes)
      (sieve 1000000)))

(write (bench))
(terpri)
