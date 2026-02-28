//
//  TimerView.swift
//  Conan
//
//  Created by Naman Deep on 23/02/26.
//

import SwiftUI

struct TimerView: View {
    
    let minutes: Int
    let selectedTag: FocusTag 
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var showCompletionAlert = false
    @State private var completedMinutes = 0
    @State private var remainingSeconds: Int = 0
    @State private var timer: Timer?
    
    var body: some View {
        ZStack{
            Color(red: 0.8, green: 0.9, blue: 0.5)
                .ignoresSafeArea()
            
            
            VStack(spacing: 30) {
                
                Text("Focus Session")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.top, 20)
                
                Spacer()
                
                Text("Time Left")
                    .font(.title)
                    .fontWeight(.bold)
                
                CircularProgressView(progress: getProgress(), timeString: timeString(from: remainingSeconds))
                    .frame(maxWidth: 250, maxHeight: 250)
                
                
                HStack(spacing: 10) {
                    Color(hex: selectedTag.colorHex)
                        .frame(width: 10, height: 10)
                        .clipShape(Circle())
                    
                    Text(selectedTag.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    Capsule()
                        .fill(Color(.systemGray5))
                )
                .overlay(
                    Capsule()
                        .stroke(Color(.systemGray4), lineWidth: 2)
                )
                
                
                Button("Stop"){
                    stopAndDismiss()
                }
                .font(Font.title)
                .frame(minWidth: 90, minHeight: 50)
                .background(Color.red)
                .foregroundStyle(Color(.white))
                .cornerRadius(20)
                
                Spacer()
            }
            .onAppear(){
                startTimer()
            }
            .onDisappear {
                timer?.invalidate()
            }
        }
        .alert("Focus Complete", isPresented: $showCompletionAlert) {
            Button("OK"){
                dismiss()
            }
        }message: {
            Text("Completed focus for \(completedMinutes) minutes.")
        }
        
    }
    
    func getProgress() -> Double {
        let total = Double(minutes * 60)
        let remaining = Double(remainingSeconds)
        
        return (remaining / total)
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
        TimerManager.shared.stop()
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
            stopTimer()
            
            
            FocusStore.shared.addSession(duration: minutes * 60, tag: selectedTag.id)
            
            completedMinutes = minutes
            showCompletionAlert = true
        }
    }
}

extension Color {
    init(hex: String) {
        let r, g, b, a: Double
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#") { hexString.removeFirst() }

        var rgba: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgba)

        switch hexString.count {
        case 6: // RRGGBB
            r = Double((rgba & 0xFF0000) >> 16) / 255.0
            g = Double((rgba & 0x00FF00) >> 8) / 255.0
            b = Double(rgba & 0x0000FF) / 255.0
            a = 1.0
        case 8: // RRGGBBAA
            r = Double((rgba & 0xFF000000) >> 24) / 255.0
            g = Double((rgba & 0x00FF0000) >> 16) / 255.0
            b = Double((rgba & 0x0000FF00) >> 8) / 255.0
            a = Double(rgba & 0x000000FF) / 255.0
        default:
            r = 0; g = 0; b = 0; a = 0
        }
        self = Color(red: r, green: g, blue: b, opacity: a)
    }
}

#Preview {
    let tag = FocusStore.shared.loadTags().first!
    TimerView(minutes: 5, selectedTag: tag)
}
