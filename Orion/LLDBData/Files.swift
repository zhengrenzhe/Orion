//
//  Files.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/27.
//

import Cache
import FileKit
import Foundation

struct Files {
    private static let fileCache = MemoryStorage<String, String>(
        config: MemoryConfig(expiry: .never, countLimit: 100, totalCostLimit: 100))

    static func loadFile(filePath: String) {
        if hasFile(filePath: filePath) {
            return
        }

        let file = TextFile(path: Path(filePath))
        var fileContent = ""
        do {
            try fileContent = file.read()
        } catch {
            print("load file \(filePath) error")
        }
        print("load file \(filePath) success")
        fileCache.setObject(fileContent, forKey: filePath)
    }

    static func hasFile(filePath: String) -> Bool {
        ((try? fileCache.existsObject(forKey: filePath)) == true)
    }
}
