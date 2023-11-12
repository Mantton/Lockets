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
    
    func addAudioContent(_ file: URL) {
        do {
            locket.attachement = try Data(contentsOf: file)
            try? FileManager.default.removeItem(at: file)
        } catch {
            print("addAudioContent", error)
        }
    }
    
    func save(_ context: ModelContext) {
        let object = locket.toLocket()
        context.insert(object)
    }
    
}

enum LocketCreationState {
    case type, content, core, preview
}
