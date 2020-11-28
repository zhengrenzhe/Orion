//
//  Files.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/27.
//

import Cache
import Combine
import FileKit
import Foundation
import SwiftEventBus

class FileStoreList: ObservableObject {
    @Published var files: [String] = []

    init() {
        SwiftEventBus.onMainThread(self, name: clearData) { _ in
            self.files.removeAll()
        }

        SwiftEventBus.onMainThread(self, name: loadFileSuccess) { res in
            if let filePath = res?.object {
                self.files.append("\(filePath)")
            }
        }
    }
}

class FileStore {
    private let fileCache = MemoryStorage<String, String>(config: MemoryConfig(
        expiry: .never, countLimit: 100, totalCostLimit: 100
    ))

    init() {
        SwiftEventBus.onMainThread(self, name: clearData) { _ in
            self.fileCache.removeAll()
        }
    }

    func hasFile(filePath: String) -> Bool {
        ((try? fileCache.existsObject(forKey: filePath)) == true)
    }

    func loadFile(filePath: String) {
        if hasFile(filePath: filePath) {
            return
        }

        do {
            let fileContent = try TextFile(path: Path(filePath)).read()
            fileCache.setObject(fileContent, forKey: filePath)
            SwiftEventBus.post(loadFileSuccess, sender: filePath)
            print("load file \(filePath) success")
        } catch {
            print("load file \(filePath) error")
        }
    }
}

let sharedFileStore = FileStore()
