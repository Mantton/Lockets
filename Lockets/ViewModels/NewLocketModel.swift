//
//  NewLocketModel.swift
//  Lockets
//
//  Created by Mantton on 2023-10-25.
//

import SwiftUI
import SwiftData

@Observable
final class NewLocketModel {
    var state: LocketCreationState = .type
    var locket = NewLocketData()
    var isSaving = false
    
    func setLocketType(_ type: LocketType) {
        withAnimation {
            locket.type = type
        }
    }
    
    func setState(_ s: LocketCreationState) {
        withAnimation {
            state = s
        }
    }
    
    func addTextContent(_ content: String) {
        locket.text = content
    }

    
    func save(_ context: ModelContext) {
        let object = locket.toLocket()
        context.insert(object)
    }
    
    func setAttachment(url: URL) {
        locket.attachement = url
    }
    
    func setAttachment(data: Data, ext: String) {
        withAnimation {
            isSaving = true
        }
        
        let temp = FileManager.default.temporaryDirectory
        
        temp.contents.forEach { url in
            try? FileManager.default.removeItem(at: url)
        }
        
        
        func getDestination() -> URL {
            temp.appending(path: "\(UUID().uuidString).\(ext)", directoryHint: .notDirectory)
        }
        var destination = getDestination()
        
        if (destination.exists) {
            repeat {
                destination = getDestination()
                print("Ran")
            } while destination.exists
        }

        
        do {
            try data.write(to: destination)
        } catch {
            print("Failed to save attachement to temp directory", error)
        }
        
        withAnimation {
            locket.attachement = destination
            isSaving = false
        }
        print("Done")
    }
    
}

enum LocketCreationState {
    case type, content, core, preview
}
