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
        ZStack(alignment: .top){
            
            ContentView()
            if focus.isRunning {
                TimerBannerView()
            }
            
        }
        
    }
    
}

#Preview {
    RootView()
}
