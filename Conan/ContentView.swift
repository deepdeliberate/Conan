//
//  ContentView.swift
//  Conan
//
//  Created by Naman Deep on 21/02/26.
//

import SwiftUI
internal import Combine

struct ContentView: View {
    

    var body: some View {
        NavigationStack{
            ZStack{
                LinearGradient(
                    colors: [
                        Color.green.opacity(0.2),
                        Color.blue.opacity(0.2),
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                TimerEditView()
                    .padding()
                    .background(.thickMaterial.opacity(0.5))
                    .cornerRadius(20)
                    .padding()
            }
            .navigationTitle("Focus")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .principal) {
                    Text("Focus")
                        .font(.title)
                        .fontWeight(.bold)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: StatsView()) {
                        Image(systemName: "chart.bar.fill")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
