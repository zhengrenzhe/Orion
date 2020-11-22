//
//  ConnectLLDB.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/22.
//

import Foundation

func connectLLDB() {
    if let pythonLaunchFile = Bundle.main.path(forResource: "launch", ofType: "py") {
        let homePath = FileManager.default.homeDirectoryForCurrentUser
        let lldbinitFilePath = homePath.appendingPathComponent(".lldbinit")

        // exist .lldbinit
        if FileManager.default.fileExists(atPath: lldbinitFilePath.path) {
            if let content = FileManager.default.contents(atPath: lldbinitFilePath.path) {
                let realContent = String(data: content, encoding: .utf8) ?? ""

                // if created by Orion, pass
                if realContent.contains("# Orion") { return }

                // else backup old .lldbinit
                let backupPath = homePath.appendingPathComponent(".lldbinit.orion.backup")
                FileManager.default.createFile(atPath: backupPath.path, contents: content)
            }
        }

        // create new .lldbinit
        let newContent = "# Orion\ncommand script import \(pythonLaunchFile)"
        FileManager.default.createFile(atPath: lldbinitFilePath.path, contents: newContent.data(using: .utf8))
    }
}
