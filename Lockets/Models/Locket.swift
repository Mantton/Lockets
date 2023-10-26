//
//  Locket.swift
//  Lockets
//
//  Created by Mantton on 2023-10-25.
//

import CloudKit
import Foundation
import SwiftData
import SwiftUI

@Model
final class Locket {
    var title: String
    var type: LocketType
    var createdAt = Date.now
    
    // Locking
    var unlocksAt: Date
    
    // Availablity
    var isUnlocked = false
    var onlyShowWhenUnlockable = false
    
    // Content
    var letter: LocketTextAttachemnt?
    var file: LocketFileAttachment?
    var link: LocketLinkAttachment?

    
    init(title: String, type: LocketType, createdAt: Foundation.Date = Date.now, unlocksAt: Date, isUnlocked: Bool = false) {
        self.title = title
        self.type = type
        self.createdAt = createdAt
        self.unlocksAt = unlocksAt
        self.isUnlocked = isUnlocked
    }
    
}



