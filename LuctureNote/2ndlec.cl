
Jan 6th
-------

Primitive data type:
- integers
- numbers
- strings 
- chars #\Q
- reals
- false nil '()
--------------------
Example functions
 (read ) ; reads next user input, returns the input from user

( format t "~A ..... ~A ...~% " x y) ; format returns nil

( format nil " same string....." x y) ; returns the string instead of displaying it

----Math Ops -----
(+ x y)
(- x y)
(mod x y) ; remainder after x/y
(sqrt x)
(log x)
(exp x y) ; x^y

----Type Checking ----
(integerp x) 
(numberp x )
(realp x)
(stringp)
(listp)
(characterp)
------------------
-----Creating Vars------

(defvar x 3)

----Set var values ------
(setf x "foo")

---- Creating constants -----
(defconstant Pi 3.14)

-----------------------------------------


Imperative Idea::

prompt the user, read their input into a variable, and then compute 3x^2 + 2x + 7. then display result.

print "enter a number"
scan(x)
result = 3x^2+2x+7
print result


--------Functional Appraoch--------

Display the result of applying the formula to value they supply, in response to a prompt 

- Create a function for applying formula to a value number
	 f(number x) {
		return 3*x*x+2*x+7 
	}
	print (f(read()))
--------------------------
Syntax for defining functions
--------------
(defun f (x)
  ; func body
)

------ Creating the function from above -----
(defun f (x) 
(+ 7 (+ (* 2 x) (* 3 (* x x))))) ; add 7 to (2*x + 3*

(f (read)) ; apply f to user input.

; Displaying result of applying f to user input
(format t "Result is ~A ~%" (f(read)))
-----------------------------------------

Prompt user first, then read response.
	; imperative appoach, use a function

(defun processFormula () ; no params
	(format t "Enter a number")
	(format t "Result is ~A ~%" (f(read))))
------ 
Lisp functions can have multiple statement, they return the value of the last statement.

-------------------------------
Intruduce error checking,
 - if
 - cond

---- If ----
(if ( condition to test ) (value to return if true) (value to return if false)
)

(if (< x y)
 (format t "~A is smaller " x) 
 (format t "~A is smaller or equal to " y ))


----- Example ------
; if x is not a number, display a message and returns nil, otherwise 
(defun f (x)
  (if (numberp x )
	(+ 7 (* 2 x) (* 3 (* (* x x))))
	(format t "~A is not a number ~%" x)))


----------------------
Purest version of function, process formula,
(just have a single statement in the function) 

(defun processFormula () 
  (if (format t "Enter a number")
  t ;  never userd because format t returns nil.
  (format t "result is ~A ~%" (f (read)))))
---------------------------------------------
I want to do steps x y z in order, but they don't necessarily return t or false

(if (or x t) ; (or x t) does x and then return t regardless of x's return value
  (if (or y t) z nil)
	nil)

--------------- Theoritical viewpoint --------------
 you can do the "print" version of a sequence of statements and compiler/interpreter can easily translate a function in impure style into purest version
........

Say I want a square root function with error checking....
	Goal:: 
		Given param x
		if x is not a number
			produce err msg
		else if x is negative 
			produce different err msg
		otherwise
			compute and return sqrt

(defun SquareRoot (x)
	(if (numberp x)
	  (if (>= x 0)
		 (sqrt x) ; return sqrt x
		(format t "~A this is negative" x))
	; x not a number, print err msg and return nil
	(format t "~A is not a number" x)))


-------------------------------------------------
If we have lots of pieces to check.  Use cond

(cond 
(condition  return_value_if_true)
()
()

(t defult_return_value))
------------------

(defun SquareRoot (x)
 (cond 
	; err checking first, discard bad data values.
	((not (numberp x)) (format t "Not a number~%"))
	; here, I know x is a number, so check for negatives
	((< x 0) (format t "Negative number"))
	; now I know is ok
	(t (sqrt x))))
----------------------
In Lisp:
list  '(val1 val2 val3) ; quote means treat as a list of data, do not evaluate as a function
'(....)
(quote (.....))
----------------------------------------
creating a list, 
(list val1 val2 val3)
-----------------------------------------
Parts of a list
( a b c d e ) 

For each list stores two parts, head and tail
(car L) ; returns the first element
(cdr L) ; returns everything except the first element
---------------------

; function head to return front element of a list
(defun head  (L) 
	(cond
	  ((not (listp L)) nil)
	  ((null L) nil)
	  (t (car L))))
------------------------------
To get the second element
(defun getsecond (L)
 (cond 
	((not (listp L)) nil)
	; if length of L is less than 2, return nil
	((< (length L) 2) nil)
	(t ( car (cdr L)))))
------

-- ShorHands
cadr = (car(cdr L))
cddr = (cdr(cdr L))
caddr = (car (cdr (cdr L)))

-------------------------
(defvar L '(1 2 3))
(cadr L) => 2
(cddr L) => '(3)
(cdr (cdr (cdr L))) => '() ; empty list

-----

To add an element to front of list
	(cons 1 '(2 3)
	'(1 2 3)
