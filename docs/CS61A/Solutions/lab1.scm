CS 61A		Lab 1		Lab Solutions

FIRST LAB:

No problems that required original solutions!

SECOND LAB:

1.  Nothing original.

2.  If the last letter is Y, then we have to look at the next-to-last:

(define (plural wd)
  (if (and (equal? (last wd) 'y)
	   (not (vowel? (last (bl wd)))))
      (word (bl wd) 'ies)
      (word wd 's)))

If you didn't think to use AND in that way, it can be done with nested IFs:

(define (plural wd)
  (if (equal? (last wd) 'y)
      (if (vowel? (last (bl wd)))
	  (word wd 's)
	  (word (bl wd) 'ies))
      (word wd 's)))

Or, if that's too messy, with a subprocedure:

(define (plural wd)
  (if (equal? (last wd) 'y)
      (y-plural (bl wd))
      (word wd 's)))

(define (y-plural prefix)
  (if (vowel? (last prefix))
      (word prefix 'ys)
      (word prefix 'ies)))

All of these assume the definition of vowel? in the handout.


3.  There are, of course, many possible ways to write this.  None is
perfectly elegant.  The difficulty is figuring out which of the three
arguments is smallest, so you can leave it out of the computation.
The way I like best, I think, is a little tricky:

(define (sum-square-large papa mama baby)
  (define (square x) (* x x))
  (cond ((> mama papa) (sum-square-large mama papa baby))
	((> baby mama) (sum-square-large papa baby mama))
	(else (+ (square papa) (square mama)))))

I think this way is pretty concise and easy to read.  However, it's okay
if you did it more straightforwardly like this:

(define (sum-square-large a b c)
  (define (square x) (* x x))
  (define (sumsq x y) (+ (square x) (square y)))
  (cond ((and (<= a b) (<= a c)) (sumsq b c))
	((and (<= b a) (<= b c)) (sumsq a c))
	(else (sumsq a b)) ))

If you didn't think of using AND to identify the conditions, it could also
be done using nested IFs:

(define (sum-square-large a b c)
  (define (square x) (* x x))
  (define (sumsq x y) (+ (square x) (square y)))
  (if (>= a b)
      (if (>= b c)
	  (sumsq a b)
	  (sumsq a c))
      (if (>= a c)
	  (sumsq a b)
	  (sumsq b c))))

Some people wanted to start by solving a subproblem: a function to find
the two largest numbers.  This can be done, but it's harder:

(define (sum-square-large a b c)
  (define (square x) (* x x))
  (define (sumsq nums) (+ (square (first nums)) (square (last nums))))
  (define (two-largest a b c)
    (cond ((and (<= a b) (<= a c)) (sentence b c))
	  ((and (<= b a) (<= b c)) (sentence a c))
	  (else (sentence a b))))
  (sumsq (two-largest a b c)))

The trick here is that a function can't return two values, so two-largest
has to return a sentence containing the two numbers.  This hardly seems
worth the effort, but the attempt to split the problem into logical pieces
was well-motivated.  It's a good idea in general, but it didn't work out
well this time.

See also:
http://code.google.com/p/jrm-code-project/wiki/ProgrammingArt


4.  Since we are examining each word of a sentence, the solution will
involve a recursion of the form (dupls-removed (bf sent)).  The base
case is an empty sentence; otherwise, there are two possibilities,
namely, (first sent) either is or isn't duplicated later in the sentence.

(define (dupls-removed sent)
  (cond ((empty? sent) '())
	((member? (first sent) (bf sent))
	 (dupls-removed (bf sent)))
	(else (sentence (first sent) (dupls-removed (bf sent))))))

