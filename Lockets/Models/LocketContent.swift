//
//  LocketContent.swift
//  Lockets
//
//  Created by Mantton on 2023-10-25.
//

import Foundation
import SwiftData

@Model
final class LocketTextAttachemnt {
    @Attribute(.allowsCloudEncryption)
    let content: String
    
    init(content: String) {
        self.content = content
    }
}

@Model
final class LocketFileAttachment {
    @Attribute(.allowsCloudEncryption)
    @Attribute(.externalStorage)
    let content: Data
    
    init(content: Data) {
        self.content = content
    }
}

@Model
final class LocketLinkAttachment {
    @Attribute(.allowsCloudEncryption)
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
}

