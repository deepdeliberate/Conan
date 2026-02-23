//
//  TimerView.swift
//  Conan
//
//  Created by Naman Deep on 23/02/26.
//

import SwiftUI

struct TimerView: View {
    let totalSeconds: Int
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var remainingSeconds: Int
    @State private var endDate: Date
    @State private var timer: Timer?
    
    init(totalSeconds: Int) {
        self.totalSeconds = totalSeconds
        _endDate = State(initialValue: Date().addingTimeInterval(TimeInterval(totalSeconds)))
        _remainingSeconds = State(initialValue: totalSeconds)
    }
    
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
                stopTimer()
            }
            
        }
        
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if remainingSeconds > 0{
                remainingSeconds -= 1
            }
            else {
                stopTimer()
            }
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
}

#Preview {
    TimerView(totalSeconds: 20)
}
