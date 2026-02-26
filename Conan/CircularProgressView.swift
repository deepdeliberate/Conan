//
//  CircularProgressView.swift
//  Conan
//
//  Created by Naman Deep on 26/02/26.
//

import SwiftUI

struct CircularProgressView: View {
    let progress: Double   // 1 -> full, 0 -> Empty
    let timeString: String
    
    var modeColor: Color = Color.green
    
    @State private var animatedProgress: Double = 1.0
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(
                    modeColor.opacity(0.2),
                    lineWidth: 20
                )
            
            Circle()
                .trim(from: 0.0, to: animatedProgress)
                .stroke(
                    modeColor,
                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
                )
                .rotationEffect(Angle(degrees: -90))
                .animation(.easeInOut(duration: 0.3), value: animatedProgress)
            
            VStack(spacing: 8) {
                Image(systemName: "brain")
                    .font(.system(size: 32))
                    .foregroundStyle(modeColor)
                
                Text(timeString)
                    .font(.system(size: 64, weight: .bold))
                    .monospacedDigit()
            }
        }
        .onAppear{
            animatedProgress = progress
        }
        .onChange(of: progress) { _ , newValue in
            animatedProgress = newValue
        }
    }
}

#Preview {
    CircularProgressView(progress: 0.9, timeString: "23:20")
}
