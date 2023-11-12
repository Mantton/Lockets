//
//  LocketPreviewView.swift
//  Lockets
//
//  Created by Mantton on 2023-10-26.
//

import SwiftUI

struct LocketPreviewView: View {
    @State private var isOpen = false
    private let animation: Animation = .easeInOut(duration: 0.65)
    let data: NewLocketData
    var body: some View {
        ZStack(alignment: .center) {
            GeometryReader { proxy in
                Group {
                    let width = proxy.size.width * 0.7
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundStyle(Color.offWhite)
                            .shadow(radius: 10)
                        LocketContentView(data: data)
                        
                    }
                    .frame(width: width, height: width * 1.5, alignment: .center)
                    .overlay {
                        Group {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundStyle(Color.offWhite)
                                .shadow(radius: 7)
                                .rotation3DEffect(
                                    .degrees(isOpen ? -165 : 0),
                                    axis: (x: 0.0, y: 1.0, z: 0.0),
                                    anchor: .leading,
                                    perspective: 0.7
                                )
                                .onTapGesture {
                                    isOpen.toggle()
                                }
                            
                        }
                    }
                }
                .rotationEffect(.degrees(isOpen ? -1.5 : 0))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .animation(animation, value: isOpen)
    }
}


struct LocketContentView : View {
    let data: NewLocketData
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            switch data.type {
            case .note:
                Text(data.text)
            case .letter:
                Text(data.text)
            case .image:
                Group {
                    if let imageData = data.attachement,
                       let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 7))
                    } else {
                        Image(systemName: "exclamationmark.triangle")
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 7))
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            case .link:
                EmptyView()
            case .audio:
                if let audio = data.attachement {
                    AudioView(audio: audio)
                } else {
                    Text("Unable to play audio")
                }
            case .video:
                EmptyView()
                
            }
        }
        .foregroundStyle(.primary)
        .padding(.all, 5)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding()
    }
}


extension LocketContentView {
    struct AudioView : View {
        let audio: Data
        @State private var player = AudioPlayer()
        var body: some View {
            VStack(alignment: .center) {
                Spacer()
                HStack {
                    Spacer()
                    Button {
                        Task {
                            player.isPlaying ? player.setIsPlaying(false) : player.play(with: audio)
                        }
                    } label: {
                        Group {
                            if player.isPlaying {
                                Image(systemName: "stop")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(.black.opacity(0.3))
                                    .shadow(color: Color.black.opacity(0.2), radius: 13.5, x: 10, y: 10)
                                    .shadow(color: Color.white.opacity(0.6), radius: 13.5, x: -5, y: -5)
                            } else {
                                Image(systemName:"play")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(.black.opacity(0.3))
                                    .offset(x: 3)
                                    .shadow(color: Color.black.opacity(0.2), radius: 13.5, x: 10, y: 10)
                                    .shadow(color: Color.white.opacity(0.6), radius: 13.5, x: -5, y: -5)
                            }
                        }

                    }
                    .frame(width: 100, height: 100)
                    .buttonStyle(NeumorphicButtonStyle())
                    Spacer()
                }
                Spacer()
            }
            .padding()
            .onDisappear {
                player.setIsPlaying(false)
            }
        }
    }
}
