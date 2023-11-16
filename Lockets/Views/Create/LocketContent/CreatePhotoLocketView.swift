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
            if let url = model.locket.attachement {
                ImageSelectedView(imageURL: url)
            } else {
                ChoosePhotoView()
            }
        }
        .animation(.default, value: model.isSaving)
        .animation(.default, value: model.locket.attachement)
    }
}


struct ChoosePhotoView: View {
    @State private var pickerSelection: PhotosPickerItem?
    @State private var cameraSelection: URL?
    @State private var presentCameraView = false
    @Environment(NewLocketModel.self) private var model
    
    var body: some View {
        VStack {
            if model.isSaving {
                ProgressView()
                    .padding()
            } else {
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
                
                Button { presentCameraView.toggle() } label: {
                    Label("Take Photo", systemImage: "camera")
                }
                .buttonStyle(.bordered)
                .controlSize(.large)
            }
        }
        .onChange(of: pickerSelection) {
            pickerSelection?.loadTransferable(type: Photo.self, completionHandler: { result in
                do {
                    let photo = try result.get()
                    guard let photo else { return }
                    model.setAttachment(data: photo.data, ext: "png")
                } catch {
                    print("Load Transferable Error", error)
                }
            })
        }
        .sheet(isPresented: $presentCameraView){
            CameraView(selection: $cameraSelection)
        }
        .onChange(of: cameraSelection) {
            guard let cameraSelection else { return }
            withAnimation {
                model.locket.attachement = cameraSelection
            }
        }
    }
}

struct ImageSelectedView: View {
    @Environment(NewLocketModel.self) private var model
    let imageURL: URL
    var body: some View {
        VStack {
            AsyncImage(url: imageURL, content: { image in
                image
                    .resizable()
                    .scaledToFit()
            }, placeholder: {
                ProgressView()
            })
            
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
        .task {
            print("Nothing")
        }
    }
}

#Preview {
    CreatePhotoLocketView()
        .environment(NewLocketModel())
    
}
