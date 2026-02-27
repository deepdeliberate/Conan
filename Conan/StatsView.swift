//
//  StatsView.swift
//  Conan
//
//  Created by Naman Deep on 25/02/26.
//

import SwiftUI

struct StatsView: View {
    
    @State private var sessions: [FocusSession] = []
    
    var body: some View {
        List(sessions) { session in
            VStack(alignment: .leading) {
                Text(session.date.formatted())
                
                Text("\(session.duration / 60) minutes")
            }
        }
        .onAppear{
            sessions = FocusStore.shared.loadSessions()
        }
        
    }
}

#Preview {
    StatsView()
}
