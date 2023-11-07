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
                    let width = proxy.size.width * 0.75
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundStyle(data.type.color)
                            .shadow(radius: 10)
                        LocketContentView(data: data)
                        
                    }
                    .frame(width: width, height: width * 1.6, alignment: .center)
                    .overlay {
                        Group {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundStyle(data.type.color)
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
                EmptyView()
            case .video:
                EmptyView()
                
            }
        }
        .padding(.all, 5)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(data.type.color)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding()
    }
}
#Preview {
    let data = NewLocketData(text: "f High Garden.")
    return LocketPreviewView(data: data)
}
