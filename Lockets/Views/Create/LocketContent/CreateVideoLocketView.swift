//
//  CreateVideoLocketView.swift
//  Lockets
//
//  Created by Mantton on 2023-11-12.
//

import PhotosUI
import SwiftUI
import AVKit

enum AttachementSource: Hashable, Identifiable {
    case camera, library
    
    var id: Int {
        hashValue
    }
    
}
// MARK: CreateVideoView
struct CreateVideoLocketView: View {
    @Environment(NewLocketModel.self) private var model
    
    var body: some View {
        ZStack {
            if let url = model.locket.attachement {
                VideoSelectedView(url: url)
            } else {
                ChooseVideoView()
            }
        }
        .animation(.default, value: model.locket.attachement)
    }
}


// MARK: ChooseVideoView

struct ChooseVideoView: View {
    @State private var source: AttachementSource?
    @State private var selection: URL?
    @Environment(NewLocketModel.self) private var model
    
    var body: some View {
        VStack {
            if model.isSaving {
                ProgressView()
                    .padding()
            } else {
                Button { source = .library } label: {
                    Label("Select From Library", systemImage: "photo.tv")
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(LocketType.video.color.opacity(0.5))
                    Text("OR")
                        .font(.headline)
                        .foregroundStyle(LocketType.video.color.opacity(0.75))
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(LocketType.video.color.opacity(0.5))
                    
                }
                .padding(.horizontal)
                
                Button { source = .camera } label: {
                    Label("Record Video", systemImage: "camera")
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
            }
        }
        .fullScreenCover(item: $source, content: { source in
            VideoView(url: $selection, fromLibrary: source == .library)
        })

        .onChange(of: selection) {
            guard let selection else { return }
            model.locket.attachement = selection
        }
    }
}

struct VideoSelectedView: View {
    @Environment(NewLocketModel.self) private var model
    let url: URL
    var body: some View {
        VStack {
            VideoPlayer(player: AVPlayer(url: url))
                .frame(height: 300)
            VStack {
                Button("Proceed") {
                    model.setState(.core)
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
                Button("Choose Another"){
                    withAnimation {
                        model.locket.attachement = nil
                    }
                }
                .font(.footnote)
                .buttonStyle(.plain)
                .foregroundStyle(.black.opacity(0.5))
                
            }
        }
    }
}

#Preview {
    CreateVideoLocketView()
        .environment(NewLocketModel())
}
