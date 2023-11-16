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
                switch model.locket.type {
                case .note:
                    CreateNoteLocketView()
                case .letter:
                    CreateLetterLocketView()
                case .image:
                    CreatePhotoLocketView()
                case .link:
                    Text("Link")
                case .audio:
                    CreateAudioLocketView()
                case .video:
                    CreateVideoLocketView()
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
