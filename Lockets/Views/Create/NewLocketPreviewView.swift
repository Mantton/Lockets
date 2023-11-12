//
//  NewLocketPreviewView.swift
//  Lockets
//
//  Created by Mantton on 2023-10-26.
//

import SwiftUI

struct NewLocketPreviewView: View {
    @Environment(NewLocketModel.self) private var model
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        
        ZStack(alignment: .bottom) {
            LocketPreviewView(data: model.locket)
                .padding(.bottom)
            VStack {
                Button("Looks Good!") {
                    model.save(modelContext)
                    dismiss.callAsFunction()
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
                
                Button("Back") {
                    model.setState(.core)
                }
                .foregroundStyle(.black.opacity(0.6))
                
            }
        }
    }
}

#Preview {
    NavigationStack {
        NewLocketPreviewView()
            .navigationTitle("New Locket")
            .environment(NewLocketModel())
    }
}
