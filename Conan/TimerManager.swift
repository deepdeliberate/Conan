//
//  TimerManager.swift
//  Conan
//
//  Created by Naman Deep on 24/02/26.
//

import Foundation

class TimerManager {
    static let shared = TimerManager()
    private let key = "timer_end_date"
    
    func start(seconds: Int){
        let endDate = Date().addingTimeInterval(TimeInterval(seconds))
        UserDefaults.standard.set(endDate, forKey: key)
    }
    
    func endDate() -> Date?{
        UserDefaults.standard.object(forKey: key) as? Date
    }
    
    func stop() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
