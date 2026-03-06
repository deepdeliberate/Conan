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
    private let activeKey = "timer_active"
    
    func start(seconds: Int){
        let endDate = Date().addingTimeInterval(TimeInterval(seconds))
        UserDefaults.standard.set(endDate, forKey: key)
        UserDefaults.standard.set(true, forKey: activeKey)
    }
    
    func endDate() -> Date?{
        UserDefaults.standard.object(forKey: key) as? Date
    }
    
    func isActive() -> Bool {
        UserDefaults.standard.bool(forKey: activeKey)
    }
    
    func stop() {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.set(false, forKey: activeKey)
    }
}
