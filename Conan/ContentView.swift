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
            TimerEditView()
        }
    }
}

#Preview {
    ContentView()
}
