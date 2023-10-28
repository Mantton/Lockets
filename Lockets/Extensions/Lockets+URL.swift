//
//  Lockets+URL.swift
//  Lockets
//
//  Created by Mantton on 2023-10-26.
//

import Foundation


extension URL {
    func createDirectory() {
        try? FileManager.default.createDirectory(at: self, withIntermediateDirectories: true, attributes: nil)
    }

    var exists: Bool {
        FileManager.default.fileExists(atPath: path)
    }

    var contents: [URL] {
        let out = try? FileManager.default.contentsOfDirectory(at: self,
                                                               includingPropertiesForKeys: [.contentModificationDateKey])
        return out ?? []
    }

    var lastModified: Date {
        let date = try? resourceValues(forKeys: [.contentModificationDateKey]).contentModificationDate
        return date ?? .distantPast
    }

    var sttBase: URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: false)
        components?.path = ""
        return components?.url
    }
}
