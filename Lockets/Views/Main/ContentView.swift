//
//  ContentView.swift
//  Lockets
//
//  Created by Mantton on 2023-10-25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            UnlockedLocketsView()
                .tabItem {
                    Label("Your Lockets", systemImage: "heart")
                }
            LockedLocketsView()
                .tabItem {
                    Label("Locked", systemImage: "lock")
                }

        }
        
    }
}

#Preview {
    ContentView()
}
