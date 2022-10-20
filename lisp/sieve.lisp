(defun sieve (size)
  (declare (optimize (speed 2) (safety 0))
           (type (unsigned-byte 64) size))

  (if (< size 2)
      '()

      ; declare sieve array `a` and return array `res`
      (let ((a (make-sequence '(vector bit) size))
            (q (floor (sqrt size))))
        (declare (type (unsigned-byte 64) q))

        ; for factor = 3; factor < q; factor += 2
        (do ((factor 3 (+ factor 2)))
            ((>= factor q))
          (declare (type (unsigned-byte 64) factor))

          ; for (unsigned int i = factor; i < size; i += 2) {
          ;   if (!a[i >> 1]) {
          ;     factor = i;
          ;     break;
          ;   }
          ; }

          (setf factor
            (do ((i factor (+ i 2)))
                ((or (>= i size) (zerop (aref a i)))
                 (if (< i size) i factor))
              (declare (type (unsigned-byte 64) i))))

          ;  for (unsigned int i = factor * factor; i < size; i += factor * 2) {
          ;    a[i >> 1] = 1;
          ;  }

          ;; DO version
          (do ((i (* factor factor) (+ i factor factor)))
              ((>= i size))
            (declare (type (unsigned-byte 64) i))
            (setf (aref a i) 1)))

        ; a[0] = 2;
        ; unsigned int n_primes_found = 1;
        ; for (unsigned int i = 3; i < size; i += 2)
        ;   if (!a[i >> 1])
        ;     a[n_primes_found++] = i;
        ; a.erase(a.begin() + n_primes_found, a.end());

        (cons 2
              (loop for i from 3 to (- size 1) by 2
                      if (zerop (aref a i))
                    collect i)))))
