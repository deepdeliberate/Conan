//
//  ConanApp.swift
//  Conan
//
//  Created by Naman Deep on 21/02/26.
//

import SwiftUI

@main
struct ConanApp: App {
    @StateObject private var focus = FocusEngine()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(focus)
        }
    }
}
