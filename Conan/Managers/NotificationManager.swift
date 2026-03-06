//
//  NotificationManager.swift
//  Conan
//
//  Created by Naman Deep on 06/03/26.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound,]) { granted, error in
            if let error = error {
                print("Notification permission error: ", error.localizedDescription)
            }
            print("Permission granted", granted)
        }
    }
    
    func schedulePomodoroNotification(minutes: Int, sessionName: String){
        let content = UNMutableNotificationContent()
        content.title = "Pomodoro Complete"
        content.body = "Focused on \(sessionName) for \(minutes) minutes"
        content.sound = .default
        
        
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: TimeInterval(minutes * 60), repeats: false
        )
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
        
        print("Notification started for \(minutes) minutes")
    }
    
    func cancelNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
