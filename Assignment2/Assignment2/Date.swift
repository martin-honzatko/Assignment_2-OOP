//
//  Date.swift
//  Assignment2
//
//  Created by Martin Honzatko on 2023-03-09.
//

import Foundation

struct Date {
	/**********************************************************************/
	/*			PRIVATE PROPERTIES				 */
	/**********************************************************************/
	private let DEFAULT_MONTH: Int = 1
	private let DEFAULT_DAY: Int = 1
	private let DEFAULT_YEAR: Int = 2000
	private let MONTHS: [(number: Int, name: String, lastDay: Int)] = [(1, "January", 31), (2, "February", 28), (3, "March", 31), (4, "April", 30), (5, "May", 31), (6, "June", 30), (7, "July", 31), (8, "August", 31), (9, "September", 30), (10, "October", 31), (11, "November", 30), (12, "December", 31)]
	
	private var _month: Int
	private var _day: Int
	private var _year: Int
	
	private var correctM = false
	private var correctD = false
	private var correctY = false
	
	/**********************************************************************/
	/*	PRIVATE(SET) AND INTERNAL PROPERTIES	 */
	/**********************************************************************/
	private(set) var month: Int {
		get { return _month}
		set {
			_month = checkMonth(newValue) ? newValue : 1
		}
	}
	
	private(set) var day: Int {
		get { return _day }
		set {
			_day = checkDay(newValue) ? newValue : 1
		}
	}
	
	private(set) var year: Int {
		get { return _year }
		set {
			_year = checkYear(newValue) ? newValue : 2000
		}
	}
	
	var format: DateFormat = .standard
	
	/**********************************************************************/
	/*				INITIALIZER					 */
	/**********************************************************************/
	init(month: Int = 1, day: Int = 1, year: Int = 2000) {
		self._month = 1
		self._day = 1
		self._year = 2000
		
		self.month = month
		self.day = day
		self.year = year
	}
	
	/**********************************************************************/
	/*				PRIVATE CHECKERS			 */
	/**********************************************************************/
	private mutating func checkMonth(_ month: Int) -> Bool {
		for val in self.MONTHS {
			if val.number == month {
				return true
			}
		}
		
		return false
	}
	
	private mutating func checkDay(_ day: Int) -> Bool {
		let maxDay = self.MONTHS[self.month - 1].lastDay
		if (day >= 1) && (day <= maxDay) {
			return true
		}
		
		return false
	}
	
	private mutating func checkDay(_ day: Int, _ month: Int) -> Bool {
		guard self.checkMonth(month) else {
			return false
		}
		
		let maxDay = self.MONTHS[month - 1].lastDay
		if (day >= 1) && (day <= maxDay) {
			return true
		}
		
		return false
	}
	
	private mutating func checkYear(_ year: Int) -> Bool {
		if year >= 0 {
			return true
		}
		
		return false
	}
	
	/**********************************************************************/
	/*			INTERNAL FUNCTIONS				 */
	/**********************************************************************/
	func show() {
		switch self.format {
			case .standard:
				print("\(self.month)/\(self.day)/\(self.year)")
			case .two:
				print(String(format: "%02d/%02d/%d", self.month, self.day, self.year%100))
			case .long:
				print("\(self.MONTHS[self.month - 1].name.prefix(3)) \(self.day), \(self.year)")
		}
	}
	
	/***************MUTATING FUNCTIONS*************************/
	mutating func setFormat(_ format: DateFormat) {
		self.format = format
	}
	
	mutating func input() {
//		self.correctM = false
//		self.correctD = false
//		self.correctY = false
		var correctI = false
		
		while correctI == false {
			print("Enter date (format: M/D/Y):", terminator: " ")
			let userInput: String = readLine() ?? ""
			
			let strs: [String] = userInput.components(separatedBy: "/")
			
			let month: Int = Int(strs[0]) ?? 0
			let day: Int = Int(strs[1]) ?? 0
			let year: Int = Int(strs[2]) ?? 0
			
			if self.checkMonth(month) && self.checkDay(day, month) && self.checkYear(year) {
				self.month = month
				self.day = day
				self.year = year
				correctI = true
			} else {
				print("Invalid date. Try again!")
			}
		}
	}
	
	mutating func set(month: Int, day: Int, year: Int) -> Bool {
		if self.checkMonth(month) && self.checkDay(day, month) && self.checkYear(year) {
			self.month = month
			self.day = day
			self.year = year
			return true
		}
		
		return false
	}
	
	mutating func increment(_ numDays: Int = 1) {
		if numDays > 0 {
			if numDays == 365 {
				self.year += 1
			} else {
				var addDays: Int = numDays
				while addDays > 0 {
					let currentMaxDay = self.MONTHS[self.month - 1].lastDay
					let currentRemainder: Int = currentMaxDay - self.day
					if addDays >= currentRemainder {
						self.day = 1
						if (self.month + 1) == 13 {
							self.month = 1
							self.year += 1
						} else {
							self.month += 1
						}
						addDays -= (currentRemainder + 1)
					} else {
						self.day += addDays
						addDays = 0
					}
				}
			}
		} else if numDays == 0 {
			print("Added 0 days. Nothing changed!")
		} else {
			print("ERROR: Only positive days can be added!")
		}
//		if numDays == 1 {
//			if (self.day == 30) || (self.day == 31) || (self.month == 2 && self.day == 28) || (self.month == 2 && self.day == 29) {
//				self.month += 1
//				self.day = 1
//			} else {
//				self.day += 1
//			}
//		} else if (numDays == 365) || (numDays == 366) {
//			self.year += 1
//		} else {
//
//		}
	}
}

extension Date: CustomStringConvertible {
	var description: String {
		return "\(self.month)/\(self.day)/\(self.year)"
	}
}

extension Date: Equatable {
	static func ==(lhs: Date, rhs: Date) -> Bool {
		return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
	}
}

extension Date: Comparable {
	static func <(lhs: Date, rhs: Date) -> Bool {
		return lhs.year < rhs.year && lhs.month < rhs.month && lhs.day < rhs.day
	}
}

enum DateFormat {
	case standard, long, two
}
