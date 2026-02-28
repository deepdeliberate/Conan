//
//  StatsView.swift
//  Conan
//
//  Created by Naman Deep on 25/02/26.
//

import SwiftUI

struct StatsView: View {
    
    @State private var sessions: [FocusSession] = []
    @State private var tags: [FocusTag] = []
    
    var body: some View {
        Group{
            if sessions.isEmpty {
                ContentUnavailableView(
                    "No Focus Sessions",
                    systemImage: "clock",
                    description: Text("Start a focus session to get started.")
                )
            }
            else{
                List(sessions) { session in
                    
                    HStack{
                        if let tag = tag(for: session.tag){
                            HStack(spacing: 6) {
                                Color(hex: tag.colorHex)
                                    .frame(width: 10, height: 10)
                                    .clipShape(Circle())
                                
                                Text(tag.name)
                                    .font(.headline)
                            }
                            
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text(session.date.formatted())
                            Text("\(session.duration / 60) minutes")
                        }
                    }
                }
            }
        }
        .onAppear{
            sessions = FocusStore.shared.loadSessions()
            tags = FocusStore.shared.loadTags()
        }
        
    }
    
    private func tag(for id: UUID) -> FocusTag?{
        FocusStore.shared.loadTags().first(where: { FocusTag in
            FocusTag.id == id
        })
    }
}

#Preview {
    StatsView()
}
