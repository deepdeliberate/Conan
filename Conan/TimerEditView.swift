//
//  TimerEditView.swift
//  Conan
//
//  Created by Naman Deep on 23/02/26.
//

import SwiftUI

struct TimerEditView: View {
    
    private let presets = [10, 15, 25, 30, 45]
    
    @State private var selectedMinutes: Int = 5
    var body: some View {
        VStack(spacing: 40){
            Text("Select Time")
                .font(.largeTitle)
            
            Stepper("\(selectedMinutes) minutes", value: $selectedMinutes, in: 1...60)
                .font(.title2)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: presets.count), spacing: 16)
            {
                ForEach(presets, id: \.self){ minutes in
                    Button{
                        selectedMinutes = minutes
                    } label: {
                        Text("\(minutes)m")
                            .frame(height: 40)
                            .frame(maxWidth: .infinity)
                            .background(
                                selectedMinutes == minutes
                                ? Color.blue
                                : Color.gray.opacity(0.3)
                            )
                            .foregroundColor(
                                selectedMinutes == minutes
                                ? .white
                                : .primary
                            )
                            .cornerRadius(10)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            NavigationLink{
                TimerView(totalSeconds: selectedMinutes * 60)
            } label: {
                Text("Start")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
        }
        .padding()
    }
}

#Preview {
    TimerEditView()
}
