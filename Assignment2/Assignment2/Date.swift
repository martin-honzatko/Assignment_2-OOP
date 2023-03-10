//
//  Date.swift
//  Assignment2
//
//  Created by Martin Honzatko on 2023-03-09.
//

import Foundation

struct Date: Comparable, CustomStringConvertible, Equatable {
	/**********************************************************************/
	/*			PRIVATE PROPERTIES				 */
	/**********************************************************************/
	private let DEFAULT_MONTH: Int = 1
	private let DEFAULT_DAY: Int = 1
	private let DEFAULT_YEAR: Int = 2000
	private let MONTHS: [(Int, String)] = [(1, "January"), (2, "February"), (3, "March"), (4, "April"), (5, "May"), (6, "June"), (7, "July"), (8, "August"), (9, "September"), (10, "October"), (11, "November"), (12, "December")]
	
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
			for val in MONTHS {
				if val.0 == newValue && correctM == false {
					_month = newValue
					correctM = true
				}
			}
		}
	}
	
	private(set) var day: Int {
		get { return _day }
		set {
			switch _month {
				case 1:
					if newValue > 0 && newValue < 32 {
						_day = newValue
						correctD = true
					}
				case 2:
					if (_year%4) == 0 {
						if newValue > 0 && newValue < 30 {
							_day = newValue
							correctD = true
						}
					} else {
						if newValue > 0 && newValue < 29 {
							_day = newValue
							correctD = true
						}
					}
					
				case 3:
					if newValue > 0 && newValue < 32 {
						_day = newValue
						correctD = true
					}
				case 4:
					if newValue > 0 && newValue < 31 {
						_day = newValue
						correctD = true
					}
				case 5:
					if newValue > 0 && newValue < 32 {
						_day = newValue
						correctD = true
					}
				case 6:
					if newValue > 0 && newValue < 31 {
						_day = newValue
						correctD = true
					}
				case 7:
					if newValue > 0 && newValue < 32 {
						_day = newValue
						correctD = true
					}
				case 8:
					if newValue > 0 && newValue < 32 {
						_day = newValue
						correctD = true
					}
				case 9:
					if newValue > 0 && newValue < 31 {
						_day = newValue
						correctD = true
					}
				case 10:
					if newValue > 0 && newValue < 32 {
						_day = newValue
						correctD = true
					}
				case 11:
					if newValue > 0 && newValue < 31 {
						_day = newValue
						correctD = true
					}
				case 12:
					if newValue > 0 && newValue < 32 {
						_day = newValue
						correctD = true
					}
				default:
					correctD = false
			}
		}
	}
	
	private(set) var year: Int {
		get { return _year }
		set {
			if newValue >= 0 {
				_year = newValue
				correctY = true
			}
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
		
		if correctM == false || correctD == false || correctY == false {
			self.month = 1
			self.day = 1
			self.year = 2000
		}
	}
	
	/**********************************************************************/
	/*				DESCRIPTION					 */
	/**********************************************************************/
	var description: String {
		return "\(self.month)/\(self.day)/\(self.year)"
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
				print("\(self.MONTHS[self.month].1.prefix(3)) \(self.day), \(self.year)")
		}
	}
	
	/***************MUTATING FUNCTIONS*************************/
	mutating func setFormat(_ format: DateFormat) {
		self.format = format
	}
	
	mutating func input() {
		self.correctM = false
		self.correctD = false
		self.correctY = false
		var correctI = false
		
		while correctI == false {
			print("Enter date (format: M/D/Y):", terminator: " ")
			let userInput: String = readLine() ?? ""
			
			let strs: [String] = userInput.components(separatedBy: "/")
			
			self.month = Int(strs[0]) ?? 0
			self.day = Int(strs[1]) ?? 0
			self.year = Int(strs[2]) ?? 0
			
			if self.correctM == false || self.correctD == false || self.correctY == false {
				print("Invalid date. Try again!")
			} else {
				correctI = true
			}
		}
	}
	
	mutating func set(month: Int, day: Int, year: Int) -> Bool {
		let oldM: Int = self.month
		let oldD: Int = self.day
		let oldY: Int = self.year
		
		self.correctM = false
		self.correctD = false
		self.correctY = false
		
		self.month = month
		self.day = day
		self.year = year
		
		if self.correctM == false || self.correctD == false || self.correctY == false {
			self.month = oldM
			self.day = oldD
			self.year = oldY
			
			return false
		}
		
		return true
	}
	
	mutating func increment(_ numDays: Int = 1) {
		if numDays == 1 {
			if (self.day == 30) || (self.day == 31) || (self.month == 2 && self.day == 28) || (self.month == 2 && self.day == 29) {
				self.month += 1
				self.day = 1
			} else {
				self.day += 1
			}
		} else if (numDays == 365) || (numDays == 366) {
			self.year += 1
		} else {
			
		}
	}
	
	/**********************************************************************/
	/*			STATIC FUNCTIONS				 */
	/**********************************************************************/
	static func <(lhs: Date, rhs: Date) -> Bool {
		return lhs.year < rhs.year && lhs.month < rhs.month && lhs.day < rhs.day
	}
	
	static func ==(lhs: Date, rhs: Date) -> Bool {
		return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
	}
}

enum DateFormat {
	case standard, long, two
}
