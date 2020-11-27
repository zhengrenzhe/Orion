//
//  Files.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/28.
//

import SwiftUI

struct Files: View {
    @EnvironmentObject private var fileStoreList: FileStoreList

    var body: some View {
        Panel(title: "files") {
            ForEach(fileStoreList.files, id: \.self) { filePath in
                Text(filePath)
            }
        }
    }
}

struct Files_Previews: PreviewProvider {
    static var previews: some View {
        Files()
    }
}
