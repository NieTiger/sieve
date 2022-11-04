#lang racket

(define (sieve size)
  (if (< size 2)
      '()
      (let ([a (make-vector size)]
            [q (floor (sqrt size))])

        (do ((factor 3 (+ factor 2)))
            ((>= factor q))

          (set! factor
            (do ((i factor (+ i 2)))
                ((or (>= i size) (zero? (vector-ref a i)))
                 (if (< i size) i factor))))

          (do ((i (* factor factor) (+ i factor factor)))
              ((>= i size))
            (vector-set! a i i)))

        (for/list ([i (in-range 3 size 2)]
                   #:when (zero? (vector-ref a i)))
                  i))))

(define res (sieve 1000000))

(define (bench)
  (do ((end (+ (current-inexact-milliseconds) 5000))
       (passes 0 (add1 passes)))
      ((> (current-inexact-milliseconds) end)
       passes)
      (sieve 1000000)))

(displayln (bench))
