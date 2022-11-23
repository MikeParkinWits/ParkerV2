//
//  ParkedTimer.swift
//  ParkerV2
//
//

// MARK: - Imports

import Foundation
import Swift
import Combine

class Stopwatch: ObservableObject {
	
	/// String to show in UI
	@Published private(set) var message = 0
	
	/// Checking the timer
	@Published private(set) var isRunning = false
	
	/// Time that we're counting from
	private var startTime: Date?
	{
		didSet { saveStartTime() }
	}
	
	/// The actual timer
	private var timer: AnyCancellable?
	
	/// Global Time & Price Values
	@Published var elapsedTime = 0.0
	@Published var timerPrice = 0
	
	/// Variable Initialization
	init() {
		startTime = fetchStartTime()
		
		if startTime != nil {
			start()
		}
	}
}

// MARK: - Public Interface

extension Stopwatch {
	func start() {
		
		/// Cancels the timer if other instances exist
		timer?.cancel()
		
		if startTime == nil {
			startTime = Date()
		}
		
		message = 0
		
		timer = Timer
			.publish(every: 0.1, on: .main, in: .common)
			.autoconnect()
			.sink { [weak self] _ in
				guard
					let self = self,
					let startTime = self.startTime
				else { return }
				
				let now = Date()
				let elapsed = now.timeIntervalSince(startTime)
				
				self.elapsedTime = elapsed
				
				self.message = Int(elapsed/60)
			}
		
		isRunning = true
	}
	
	func stop() {
		timer?.cancel()
		timer = nil
		startTime = nil
		isRunning = false
		message = 0
		timerPrice = 0
	}
}

// MARK: - Private implementation

private extension Stopwatch {
	func saveStartTime() {
		if let startTime = startTime {
			UserDefaults.standard.set(startTime, forKey: "startTime")
		} else {
			UserDefaults.standard.removeObject(forKey: "startTime")
		}
	}
	
	func fetchStartTime() -> Date? {
		UserDefaults.standard.object(forKey: "startTime") as? Date
	}
}
