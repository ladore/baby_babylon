# baby_babylon
lookup strings in cyrrilic


each string is represented as a matrix in the form:

^абвгдежзийклмнопрстуфхчшщъьюя$

0000000000000000100000000000000

0000000000000000000000000000000

0000000000000000000000000000000

0000000000000000000000000000000

0000000000000000000000000000000

0000000000000000000000000000000

0000000000000000000000000000000

0000000000000000000000000000000

0000000000000000000000000000000

0000000000000000000000000000000

0000000000000000000000000000000

0000000000000000000000000000000

0000000000000000000000000000000

0000000000000000000000000000000

0000000000000000000000000000001

0000000000000000000000000000000

0000000000000000000000000000010

0000000000000000000000000000000

0000000000000000000000000000000

0000000000000000000000000000000

0000000000000010000000000000000

0000000000000000000000000000000

0000000000000000000000000000000

0000000000000000000000000000000

0000000000000000000000000000000

0000000000000000000000000000000

0000000000000000000000000000000

0000000000000000000000000000000

0000000000000000000000000000000

0000000000000000000010000000000

0000000000000000000000000000000

0000000000000000000000000000000

0000000000000000000000000000000 


e.g each symbol points to the next one ^->п->а->у->н->$

the result is then packed, and the queries run a XOR on each array element, returning the bits that differ.

Thus, the word -> паун is considered closest to imaginary search string пяун

Feel free to comment