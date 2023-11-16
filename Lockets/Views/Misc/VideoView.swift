//
//  VideoView.swift
//  Lockets
//
//  Created by Mantton on 2023-11-13.
//

import UIKit
import SwiftUI
import UniformTypeIdentifiers

struct VideoView: UIViewControllerRepresentable {
    @Binding var url: URL?
    var fromLibrary: Bool
    @Environment(\.dismiss) private var dismiss
    
    typealias UIViewControllerType = UIImagePickerController

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = fromLibrary ? .photoLibrary : .camera
        imagePicker.mediaTypes = [UTType.movie.identifier]
        imagePicker.videoMaximumDuration = 5 * 60 // 5 Minutes

        if !fromLibrary {
            imagePicker.cameraCaptureMode = .video
            imagePicker.videoQuality = .typeHigh
        }

        imagePicker.delegate = context.coordinator

        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}


extension VideoView {
        
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: VideoView
     
        init(_ parent: VideoView) {
            self.parent = parent
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let url = info[.mediaURL] as? URL
            
            if let url {
                parent.url = url
            }
            parent.dismiss.callAsFunction()
        }
    }

}
