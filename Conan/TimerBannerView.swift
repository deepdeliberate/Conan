//
//  TimerBannerView.swift
//  Conan
//
//  Created by Naman Deep on 02/03/26.
//

import SwiftUI

struct TimerBannerView: View {
    @EnvironmentObject var focus: FocusEngine
    
    var body: some View {
        VStack() {
            Text("Study Session #\(focus.sessionNumber)")
                .font(.headline)
            
            Text(timeString(from: focus.remainingSeconds))
                .font(.largeTitle)
                .bold()
        }
        .padding(10)
        .background(Color.green.opacity(0.2))
        .clipShape(Capsule())
    }
    
    func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        
        return String(format: "%02d:%02d", minutes, secs)
    }
}

#Preview {
    TimerBannerView()
}
