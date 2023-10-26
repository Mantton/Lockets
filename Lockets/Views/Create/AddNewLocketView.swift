//
//  AddNewLocketView.swift
//  Lockets
//
//  Created by Mantton on 2023-10-25.
//

import SwiftUI

struct AddNewLocketView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var model = NewLocketModel()
    var body: some View {
        NavigationStack {
            TabView(selection: $model.state) {
                NewLocketTypeView()
                    .tag(LocketCreationState.type)
                LocketContentGatewayView()
                    .tag(LocketCreationState.content)
                
                NewLocketCoreInfoView()
                    .tag(LocketCreationState.core)
                
                NewLocketPreviewView()
                    .tag(LocketCreationState.preview)

            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .navigationTitle("New Locket")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: dismiss.callAsFunction) {
                        Label("Cancel", systemImage: "xmark")
                    }
                }
            }
            .environment(model)
            .onAppear {
                  UIScrollView.appearance().isScrollEnabled = false
            }
        }
    }
}



#Preview {
    AddNewLocketView()
}
