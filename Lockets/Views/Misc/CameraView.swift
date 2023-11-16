//
//  ImagePickerView.swift
//  Lockets
//
//  Created by Mantton on 2023-11-12.
//

import UIKit
import SwiftUI

struct CameraView: UIViewControllerRepresentable {

    @Binding var selection: URL?
    @Environment(\.dismiss) private var dismiss
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CameraView>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        imagePicker.delegate = context.coordinator

        return imagePicker
    }
 
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<CameraView>) {
 
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}


extension CameraView {
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     
        var parent: CameraView
     
        init(_ parent: CameraView) {
            self.parent = parent
        }
     
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let url = info[.imageURL] as? URL {
                parent.selection = url
            }
            parent.dismiss.callAsFunction()
        }
    }
}
