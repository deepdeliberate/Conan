//
//  RootView.swift
//  Conan
//
//  Created by Naman Deep on 02/03/26.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var focus: FocusEngine
    
    var body: some View {
        VStack(spacing: 0){
            if focus.isRunning {
                TimerBannerView()
            }
            
            ContentView()
            
        }
        
    }
    
}

#Preview {
    RootView()
}
