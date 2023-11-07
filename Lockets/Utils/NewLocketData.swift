//
//  NewLocketData.swift
//  Lockets
//
//  Created by Mantton on 2023-10-26.
//

import Foundation


struct NewLocketData {
    var type: LocketType = .note
    var text: String = ""
    var attachement: Data?
    var link: URL?
    var unlocksAt = Date.now
    var onlyShowWhenUnlockable = false
    
    
    func toLocket() -> Locket {
        let locket = Locket(type: type, unlocksAt: unlocksAt)
        locket.onlyShowWhenUnlockable = onlyShowWhenUnlockable
        
        let preppedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !preppedText.isEmpty {
            let letter = LocketTextAttachemnt(content: preppedText)
            locket.letter = letter
        }
        
        if let attachement {
            locket.file = LocketFileAttachment(content: attachement)
        }
        
        if let link {
            locket.link = LocketLinkAttachment(url: link)
        }
        
        return locket
    }
}
