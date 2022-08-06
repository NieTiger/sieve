(defun sieve (size)
  (if (< size 2)
      '()
      (let ((a (make-array size :element-type 'boolean :initial-element nil))
            (res '(2)))
        (do ((q (floor (sqrt size)))
             (factor 3 (+ factor 2)))
            ((>= factor q)
             a)
            (progn 
              (setf factor 
                    (do ((i factor (+ i 2)))
                        ((or (not (aref a i)) (>= i size))
                         i)))

              (do ((i (* factor factor) (+ i factor factor)))
                  ((>= i size) nil)
                  (setf (aref a i) t))))

        (do ((i 3 (+ i 2)))
            ((>= i size) (reverse res))
            (if (not (aref a i)) 
                (setf res (cons i res)))))))

