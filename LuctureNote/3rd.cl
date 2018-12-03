Lists:
 car : 1st element of L
 cdr : list of all the other elements of L
 (cons E L) adds E as the first element of L
 (listp L) true if L is a list, false otherwise
 (null L) true if L is an empty list, false otherwise
 (length L) # elements in L

 write a function to compute length of list L
   
   (defun length (L)
	(cond 
	  ((not (listp L)) nil) ; not a list, return nil
	  ((null L) 0) ; empty list
	  ; length of L will be the length of its tale + 1
	  (t (+ 1) (length (cdr)))))
	
 	;Function call
	(length '(10 12 2))
	1 + (length '(12 3))
	1 + (length '(3))
	1 + (length '())
	0

----------------------

; (member e L) return true if e is in L, false otherwise
 
(defun member (e L)
  (cond 
	((not (listp L)) nil) ; not a list
	((null L) nil) ; e can't be in an empty list
	((equalp e (car L)) t) ; e matches the front element of L
	((t (member e (cdr L))))))

   ; (member e L)

--------------------------------
four different ways to test equality
= ; used to see if two numbers are equivalent ie. (= 3 3.0) 

(equalp) ; test if any two values are equivalent ie, works for any data type

(eql) ; test if etiher two things are the same item, or one is a variable and the other is a literal value that exactly matches the variable content. ie, (eql x 3.5)

(eq) ; test if two things are actually the same item
 ---------------------------------------------------------
(append L1 L2) ; return a list whose elements are the elements of L1 followed by the elements of L2

(append '(10 20 30) '(3 2 1))
  --> '(10 20 30 3 2 1)

(defun append (L1 L2)
  (cond 
	((not (listp L1)) nil) ; bad L1
	((not (listp L2)) nil) ; bad L2
	((null L1) L2) ;  one of the lists is empty
	((null L2) L1)  ; return the other one.
	; get first element of L1, do a recursive call to figure out the rest, cons two together.
	(t (cons (car L1) (append (cdr L1) L2)))))

	----   Aside: makes one recursive call for each element of L1 
		- not efficient if L1 os big.
----------------------------------------------
(reverse L) ; return a copy of L with the opposite order for its element.

(defun reverse (L) 
  (cond 
	((not (listp L)) nil)
	((null L) L) ; reverse of empty list is the empty list
	(t (revHelp L '())))) ; use the helper function, nothing computed toward sofar yet.



(revHelp L sofar) ; L what needs to be reversed, sofar: stuff I've already reversed

 (defun revHelp (L soFar)
    (cond 
	; if this isn't called by anything except reverse, I can skip error checking
	((null L) soFar) ;  end  of the list, the answer is whatever I computed so far
	(t ; move front element of L to soFar and call recursively
		(revHelp (cdr L) (cons (car L) soFar)))))
-----------------------------------------------------------
(last L) ; return last element of L
 

 (defun last (L)
  (cond 
	((not (listp L)) nil) ; not a list
	((null L) nil) ; empty list?
	((null (cdr L)) (car L)) ; only one element, return it
	(t ; look for the last element in the tail
	(last (cdr L)))))

----------------------------------------------------------------------
(butLast L) ; return a copy of L, but the last element removed.

 (defun butLast (L)
  (cond 
	((not (listp L)) nil) ; not a list
	((null L) nil) ; nothing in the list
	((null (cdr L)) nil) ; only one element in L, return empty list
	(t ; take front element of L and add it to front of recursive call on tail of L
		(cons (car L) (butLast (cdr L))))))
----------------------------------------------
In lisp,

- you can create: 
 	-  multidimentional arrays: Lists of lists

	- vectors: one dimentional array
		(vectorp v) ; check if it is a vector)
	- Strings: vector of chars

(svref v position) return the element in that position
	(setf (svref v position) value) ; set the value in that position

(aref arr '(3 4)) ;  row 3, col 4,,,, returns value in that position

(make-array '(3 4 2)) ; dimensions of the array to create

(setf (aref arr '(1 3 1)) value) ; set a value in the array

(array-dimension arr) ; return a list of the array dimensions


--------------------------------------------------------------------
(defun nth (L pos)
  (cond 
	((not (listp L)) nil)
	((not (integerp pos)) nil)
	((< 0 pos) nil) ; negative position, error
	((null L) nil) ; empty list
	((equalp pos 0) (car L)) ; want the fornt element
	(t  ; look for element in position pos-1 in the tail
		(nth (cdr L) (- pos 1)))))

------------------------------------------------------------------------

Everything in lisp boils down to lists

(defun square (x)
  (cond 
	((not (numberp x)) nil)
	(t (* x x))))

; you can pass this by adding ' in the beginning.

(getfname f) ; f pass the def of a function

(defun getfname (f)
  (cond 
    ((not (listp f)) nil) ; not a list
    ((< (length f) 4) nil) ; can't be a valid 
    ((not (equalp (car f) 'defun)) nil) ; not valid func def
    (t (car(cdr f))))) ; return whatever os in the 2nd element
---------------------------------------------

let blocks......
; allow you to have local vars in lisp

(let
; a list of local vars defs, where each is a pair, (name value)

;var defs
(
	(x 0)
	(y 203)
	(z '(1 2 3))    ) ;  end of list of vars

	;body: things to do, 1 or more statements, let block returns result of last statement 

)

(defun computeProd ()
  ; get user to enter two values, return product of them,
   (let ((x 0) (y 0)) ; two local vars initialized to 0
   ; prompt user and read results into x,y
   (format t "Please enter two numbers ~%")
  ; read x and y
  (setf x (read))
  (setf y (read))
  ; compute result and return it
  (if (and (numberp x) (numberp y)) ; return product
	(* x y)
 	(format t "bad input ~A, ~A ~%" x y))))




