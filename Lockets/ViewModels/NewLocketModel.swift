//
//  NewLocketModel.swift
//  Lockets
//
//  Created by Mantton on 2023-10-25.
//

import SwiftUI


@Observable
final class NewLocketModel {
    var state: LocketCreationState = .type
    
    var locketType: LocketType = .note
    var locketName: String = "" // TODO: Possibly a random name generator for this?
    
    var locket = Locket(title: "", type: .letter, unlocksAt: .now.advanced(by: 3600))
    
    
    func setLocketType(_ type: LocketType) {
        withAnimation {
            locketType = type
        }
    }
    
    func setState(_ s: LocketCreationState) {
        withAnimation {
            state = s
        }
    }
    
    func addNoteContent(_ content: String) {
        let sub = LetterContent(content: content)
        locket.letter = sub
    }
    
}

enum LocketCreationState {
    case type, content, core, preview
}
