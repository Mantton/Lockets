//
//  LocketType.swift
//  Lockets
//
//  Created by Mantton on 2023-10-25.
//

import SwiftUI

enum LocketType: Int, Codable {
    case note, letter, image, link, audio, video
}


extension LocketType {
    var color: Color {
        switch self {
        case .note:
            return Color(hex: "006d77")
        case .letter:
            return Color(hex: "83c5be")
        case .image:
            return Color(hex: "219ebc")
        case .link:
            return Color(hex: "8ecae6")
        case .audio:
            return Color(hex: "d1b3c4")
        case .video:
            return Color(hex: "e29578")

        }
    }
}


extension LocketType {
    var name: String {
        switch self {
        case .note:
            return "Note"
        case .letter:
            return "Letter"
        case .image:
            return "Photo"
        case .link:
            return "Link"
        case .audio:
            return "Audio"
        case .video:
            return "Video"
        }
    }
}


extension LocketType {
    var image: String {
        switch self {
        case .note:
            return "note"
        case .letter:
            return "book"
        case .image:
            return "photo"
        case .link:
            return "link"
        case .audio:
            return "headphones"
        case .video:
            return "videoprojector"
        }
    }
}
