//
//  FocusEngine.swift
//  Conan
//
//  Created by Naman Deep on 02/03/26.
//

import SwiftUI
internal import Combine

class FocusEngine: ObservableObject {
    
    @Published var isRunning = false
    @Published var remainingSeconds: Int = 0
    @Published var sessionNumber: Int = 1
    
    private var timer: Timer?
    
    func start(minutes: Int){
        isRunning = true
        remainingSeconds = minutes * 60
        sessionNumber += 1
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.remainingSeconds > 0{
                self.remainingSeconds -= 1
            } else {
                self.stop()
            }
        }
    }
    
    func stop(){
        timer?.invalidate()
        isRunning = false
    }
}
