//
//  LocketContent.swift
//  Lockets
//
//  Created by Mantton on 2023-10-25.
//

import Foundation
import SwiftData

@Model
final class LetterContent {
    @Attribute(.allowsCloudEncryption)
    let content: String
    
    init(content: String) {
        self.content = content
    }
}

@Model
final class PhotoContent {
    @Attribute(.allowsCloudEncryption)
    @Attribute(.externalStorage)
    let photo: Data
    
    init(photo: Data) {
        self.photo = photo
    }
}

@Model
final class SongContent {
    @Attribute(.allowsCloudEncryption)
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
}

@Model
final class VoiceRecordingContent {
    @Attribute(.allowsCloudEncryption)
    @Attribute(.externalStorage)
    let recording: Data
    
    init(recording: Data) {
        self.recording = recording
    }
}

@Model
final class VideoRecordingContent {
    @Attribute(.allowsCloudEncryption)
    @Attribute(.externalStorage)
    let recording: Data
    
    init(recording: Data) {
        self.recording = recording
    }
}
