//
//  LockedLocketsView.swift
//  Lockets
//
//  Created by Mantton on 2023-10-25.
//

import SwiftUI

struct LockedLocketsView: View {
    @State private var presentNewLocketSheet = false
    var body: some View {
        NavigationStack {
            List {
                
            }
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
