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
    
    func addNoteContent(_ content: String) {
        locket.text = content
    }
    
    func setTitle(_ title: String) {
        locket.title = title
    }
    
    func save(_ context: ModelContext) {
        let object = locket.toLocket()
        context.insert(object)
    }
    
}

enum LocketCreationState {
    case type, content, core, preview
}
