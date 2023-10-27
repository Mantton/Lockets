//
//  CreatePhotoLocketView.swift
//  Lockets
//
//  Created by Mantton on 2023-10-26.
//

import UIKit
import SwiftUI
import PhotosUI

struct CreatePhotoLocketView: View {
    @Environment(NewLocketModel.self) private var model
    
    var body: some View {
        ZStack {
            if let data = model.locket.attachement {
                ImageSelectedView(data: data)
            } else {
                ChoosePhotoView()
            }
        }
    }
}


struct ChoosePhotoView: View {
    @State private var pickerSelection: PhotosPickerItem?
    @Environment(NewLocketModel.self) private var model
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $pickerSelection, matching: .images) {
                Label("Select From Library", systemImage: "photo")
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
            HStack {
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(LocketType.image.color.opacity(0.5))
                Text("OR")
                    .font(.headline)
                    .foregroundStyle(LocketType.image.color.opacity(0.75))
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(LocketType.image.color.opacity(0.5))
                
            }
            .padding(.horizontal)
            
            Button {} label: {
                Label("Take Photo", systemImage: "camera")
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
        }
        .onChange(of: pickerSelection) {
            pickerSelection?.loadTransferable(type: Photo.self, completionHandler: { result in
                do {
                    let photo = try result.get()
                    withAnimation {
                        model.locket.attachement = photo?.data
                    }
                } catch {
                    print(error)
                }
            })
        }
    }
}

struct ImageSelectedView: View {
    @Environment(NewLocketModel.self) private var model
    let data: Data
    var body: some View {
        VStack {
            Image(uiImage: UIImage(data: data) ?? .init(systemName: "exclamationmark.triangle")!)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 7))
                .shadow(color: .accentColor.opacity(0.5), radius: 7)
                .padding()
            
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
    CreatePhotoLocketView()
        .environment(NewLocketModel())
    
}
