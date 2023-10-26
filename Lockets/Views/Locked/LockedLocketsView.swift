//
//  LockedLocketsView.swift
//  Lockets
//
//  Created by Mantton on 2023-10-25.
//

import SwiftUI
import SwiftData

let today = Date()
struct LockedLocketsView: View {
    @State private var presentNewLocketSheet = false
    @Query(filter: #Predicate<Locket> {
        !$0.isUnlocked &&
        $0.unlocksAt < today
    }, sort: \.unlocksAt)
    private var available: [Locket]
    
    @Query(filter: #Predicate<Locket> {
        !$0.isUnlocked &&
        $0.unlocksAt > today &&
        !$0.onlyShowWhenUnlockable
    }, sort: \.unlocksAt)
    private var upcoming: [Locket]
    
    var body: some View {
        NavigationStack {
            List {
                
                Section {
                    ForEach(available) { locket in
                        Text(locket.title)
                            .listRowSeparator(.hidden)

                    }
                } header: {
                    Text("Available")
                }
            
                Section {
                    ForEach(upcoming) { locket in
                        Text(locket.title)
                            .listRowSeparator(.hidden)

                    }
                } header: {
                    Text("Upcoming")
                }

            }
            .listStyle(.plain)
            .headerProminence(.increased)
            .navigationTitle("Locked Lockets ")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: present) {
                        Label("New Locket", systemImage: "plus")
                    }
                }
            }
            .fullScreenCover(isPresented: $presentNewLocketSheet) {
                AddNewLocketView()
            }
        }
    }
}

extension LockedLocketsView {
    func present() {
        presentNewLocketSheet.toggle()
    }
}

#Preview {
    LockedLocketsView()
}
