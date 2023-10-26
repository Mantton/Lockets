//
//  LocketContentGatewayView.swift
//  Lockets
//
//  Created by Mantton on 2023-10-25.
//

import SwiftUI

struct LocketContentGatewayView : View {
    @Environment(NewLocketModel.self) private var model
    var body: some View {
        VStack {
            Group {
                switch model.locketType {
                case .note:
                    CreateNoteLocketView()
                case .letter:
                    Text("Letter")
                default:
                    Text("Not Implemented")
                }
            }
        }
        .padding()
    }
}


struct LocketContentGatewayNavigationView: View {
    let isNextDisabled: Bool
    let action: () -> Void
    @Environment(NewLocketModel.self) private var model
    
    var body: some View {
        HStack {
            Button("Back"){
                model.setState(.type)
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
            Spacer()
            Button("Next"){
                action()
                model.setState(.core)
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
            .disabled(isNextDisabled)
        }
    }
}

#Preview {
    LocketContentGatewayView()
        .environment(NewLocketModel())
}
