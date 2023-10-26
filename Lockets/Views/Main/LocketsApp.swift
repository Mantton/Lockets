//
//  LocketsApp.swift
//  Lockets
//
//  Created by Mantton on 2023-10-25.
//

import SwiftUI
import SwiftData

@main
struct LocketsApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Locket.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
