//
//  TimerView.swift
//  Conan
//
//  Created by Naman Deep on 23/02/26.
//

import SwiftUI

struct TimerView: View {
    
    let minutes: Int
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var remainingSeconds: Int = 0
    @State private var timer: Timer?
    
    var body: some View {
        ZStack{
            Color(red: 0.8, green: 0.9, blue: 0.5)
                .ignoresSafeArea()
            
            
            VStack(spacing: 30) {
                Text("Time Left")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(timeString(from: remainingSeconds))
                    .font(.system(size: 60, weight: .bold))
                
                Button("Stop"){
                    stopAndDismiss()
                }
                .font(Font.title)
                .frame(minWidth: 90, minHeight: 50)
                .background(Color.red)
                .foregroundStyle(Color(.white))
                .cornerRadius(20)
            }
            .onAppear(){
                startTimer()
            }
            .onDisappear {
                timer?.invalidate()
            }
            
        }
        
    }
    
    func startTimer() {
        let seconds = minutes * 60
        TimerManager.shared.start(seconds: seconds)
        
        updateRemainingTIme()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            updateRemainingTIme()
        }
    }
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func stopAndDismiss(){
        stopTimer()
        dismiss()
    }
    
    func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        
        return String(format: "%02d:%02d", minutes, secs)
    }
    
    func updateRemainingTIme() {
        guard let endDate = TimerManager.shared.endDate() else {
            dismiss()
            return
        }
        
        let remaining = Int(ceil(endDate.timeIntervalSinceNow))
        
        if remaining > 0 {
            remainingSeconds = remaining
        } else {
            remainingSeconds = 0
            TimerManager.shared.stop()
        }
    }
}

#Preview {
    TimerView(minutes: 5)
}
