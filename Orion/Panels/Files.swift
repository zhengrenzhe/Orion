//
//  Files.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/28.
//

import SwiftUI

struct Files: View {
    @EnvironmentObject private var fileList: FileList

    @State private var searchKey: String = ""

    var searchField: some View {
        HStack {
            TextField("search-file-placeholder", text: $searchKey)
                .font(.system(size: 12))
                .foregroundColor(.primary)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(.vertical, 3)
                .padding(.horizontal, 8)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.gray.opacity(0.6), lineWidth: 1)
                )
                .background(Color(NSColor.controlBackgroundColor))
                .cornerRadius(4)
        }
        .padding(.horizontal, 8)
        .padding(.bottom, 6)
    }

    var body: some View {
        Panel(title: "files", autoScroll: true, titleMore: searchField) {
            ForEach(fileList.files, id: \.self) { filePath in
                Text(filePath)
                    .lineLimit(0)
                    .padding(.all, 4)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .help(filePath)
            }
        }
    }
}

struct Files_Previews: PreviewProvider {
    @State static var searchKey = ""

    static var previews: some View {
        ZStack {
            TextField("", text: $searchKey)
        }
        .padding(.all, 10)
        .frame(width: 200)
    }
}

extension NSTextField {
    override open var focusRingType: NSFocusRingType {
        get { .none }
        set {}
    }
}
