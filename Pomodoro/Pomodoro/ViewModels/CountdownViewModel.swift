//
//  CountdownViewModel.swift
//  Pomodoro
//
//  Created by Leptos on 5/17/22.
//

import Foundation

final class CountdownViewModel: ObservableObject {
    let totalDuration: TimeInterval
    @Published private var startDate: Date?
    @Published private var remainingDuration: TimeInterval
    
    init(duration: TimeInterval) {
        self.totalDuration = duration
        self.remainingDuration = duration
    }
    
    var isRunning: Bool {
        startDate != nil
    }
    
    func resume() {
        guard startDate == nil else { return } // already running
        startDate = .now
    }
    
    func pause() {
        guard let baseDate = startDate else { return } // already paused
        remainingDuration += baseDate.timeIntervalSinceNow
        self.startDate = nil
    }
    
    func timeIntervalRemaining(for observer: Date = .now) -> TimeInterval {
        guard let startDate = startDate else { return remainingDuration }
        return remainingDuration - observer.timeIntervalSince(startDate)
    }
    
    /// If the timer is running, returns the date when the timer will complete if it is not paused,
    /// otherwise `nil`
    var estimatedExpiry: Date? {
        startDate?.addingTimeInterval(remainingDuration)
    }
}
