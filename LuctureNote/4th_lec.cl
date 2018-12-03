January, 13th

Recursive use of the stack.
eg.

(defun length (L)
  (if (null L) 0
	(+ 1 (length (cdr L)))))

Runtime stack: each call gets its own allocated stack space, cleaned up when call ends.
	- space might include:
		- space for return value, params, local vars, etc

if we have a length N list
	then we wind up with N + 1 stacj frams just before recursion unwinds.

GOAL: is to rewrite our recursion in a way that allows us to eliminate the extra stack frames.
	- Rewrite in a way the interpreter/compiler can recognize as suitable for optimization 
	- Compiler/interpreter must actually be capable of applying the optimization

---FORMAT---
Tail recursion:
	- every recursive call in a function must result in an immediate return from the function.
		The example above:: adds 1 to the result then return.

Tail recursive version of length
	(defun length (L)
		; call a tail recursive version that uses an extra param
		(lengthTR L 0))

	(defun lengthTR (L sofar)
	; sofar is a count of the elements we've already processed, L is the remaining elements
	(if (null L) sofar ; no more elements, 
		(lengthTR (cdr L) (+ 1 sofar)))) ; adds 1 to count and call recursively on tail.

|	|
|	|
|frame2	|
|frame1	|
|frame0	|	return value for all these stacj frames winds up being the same
|	|
|	|



Optimization: compiler recognizes a function as tail recursive (or not) and if it is tail recursion
	- instead of creating a new stack frame when a recursive call is made, it simply overwites the current stack frame. It works since the original stack frame except for the return value and that return value will be the same as the one from the recursive call anyhow.

	- If your compiler/ interpreter is capable of handling it, then tail recursion is a bit faster and a lot more space efficient. 

Examples of tail rec function..

	Reverse::
	(defun reverse (L)
	 (cond
		((not (listp L)) nil)
		((null L) nil)
		(t (app2rev L nil))))

	(defun app2rev (L app)
	; reverse L & add the rest on the end
	  (cond 
		((null L) app)
		; nothing happens between the recursive call and return, so this is tail rec, and can be optimized by compiler.
		(t (app2rev (cdr L) (cons (car L) app)))))
		 

Ex: Append 
(old version)
	(defun append (L1 L2)
	(cond
		((or (not (listp L1)) (not (listp L2))) nil) ; bad params
		((null L1) L2)
		((null L2) L2)
		(t (cons (car L1) (append (cdr L1) L2)))))

Ideally::::
	; tail rec append
	(defun appendTR (L1 L2)
	  (cond
		((not (listp L1)) nil)
		((not (listp L2)) nil)
		((null L1) nil)
		((null L2) nil)
		(t (app2rev (reverse L1) L2))))

---------------------------------------
Optioanl paramaters and default values:
	(defun f (x y z &optional (a 1) (b "foo"))) <-- pairs of param names and their default value, if caller supplies a subset of the optional params they get filled in left to right.


Ex:

	(defun reverse (L &optional (soFar nil)) <-- start over acumulator at the default value, caller never needs to know about it.
		(if (null L) sofar
		(reverse (cdr L) (cons (car L) sofar))))

Structures: records, structs: data structures with fields.
	implemented using lists

	Maunal approach::: Suppose I want to represent a binary tree using lists
	my tree structure will be a list of three elements, 1st will be list of data contents
		(ListofDataContents Left  Right)
	1st arg: what is the data stored supposed to be
	2nd, 3rd arg: nil if no left/right subtree

eg::

		3,"foo"
	      /	      \
 	     /	       \
	    /		\
	  5,"stuff"	 12,"junk"
			/
		       /
		      4,"nada"

((3 "foo") ((5 "stuff") nil nil) ((12 "junk") ((4 "nada") nil nil) nil))
	    'left subtree of root' 'right subtree of root'

(defun createNode (data)
	(if (not (listp data )) nil
		(list data nil nil))
	Idea is to  Create a node with empty subtrees and the given data.

(defun getLeft (tree)
	(cond
		((not (listp tree)) nil)
		((/= 3 (length tree)) nil)
		(t (cadr tree))))
(defun setLeft (tree)
	(cond 
	  ((not (listp tree)) nil)
	  ((/= 3 (length tree)) nil)
	  (t (setf (cadr tree) left))))

NOTE::: I pick the content structure and call to adhere to that..


-----------------
Lisp Structures:
	- I can officially define a type of structure, detailing the field names & lisp auto generates a bunch of support functions.
 (defstruct Tree data left right) ;  I define the name of struct & its fields
	; This automatically creates a function a to create a tree (make-tree) returns an uninitialized  tree
(Tree-p x) ; returns true if x is a tree, nil otherwise
(Tree-data x) ----
(Tree-left x) ; any of those, return approperiate value if x
(Tree-right x)----

(copy-Tree x) ; returns a duplicate of x

(setf (Tree-left x) nil) ;sets value of that field..
