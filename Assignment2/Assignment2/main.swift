//
//  main.swift
//  Assignment2
//
//  Created by Martin Honzatko on 2023-03-09.
//

import Foundation

var d1 = Date()            // January 1, 2000
var d2 = Date(month: 4, day: 10, year: 1992) // April 10, 1992

print(d1.year)     // this is okay
// d1.year = 2002  // this is not okay (compile-error!)
print(d2)

d1.show()
d2.show()

d1.input() //3/31/1 - allow user to enter a date for d1
d1.show()  // date must be updated based on the input above

d1.setFormat(.long)  // change the format of d1 to long format
d1.show()            // show in long format
print("increment by 1...") //Apr 1, 1
d1.increment(1)
d1.show()
print("increment by 100...") //Jul 10, 1
d1.increment(100)
d1.show()
print("increment by 365...") //Jul 10, 2
d1.increment(365)
d1.show()

// and so on... Add your own tests to fully test the functionalities.
