//
//  Lockets+FileManager.swift
//  Lockets
//
//  Created by Mantton on 2023-10-26.
//

import Foundation

extension FileManager {
    var documentDirectory: URL {
        urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    var libraryDirectory: URL {
        urls(for: .libraryDirectory, in: .userDomainMask)[0]
    }

    var applicationSupport: URL {
        urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
    }
}
