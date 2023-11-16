//
//  Photo.swift
//  Lockets
//
//  Created by Mantton on 2023-10-26.
//  Reference: https://developer.apple.com/videos/play/wwdc2023/10107/

import Foundation
import PhotosUI
import SwiftUI

struct Photo: Transferable {
    let data: Data
    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(importedContentType: .image) { data in
            Photo(data: data)
        }
    }
}

struct Video: Transferable, Equatable {
    let data: Data
    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(importedContentType: .appleProtectedMPEG4Video) { data in
            Video(data: data)
        }
    }
}
