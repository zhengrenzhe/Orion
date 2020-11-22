//
//  Panel.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/22.
//

import SwiftUI

struct Panel<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme

    var content: () -> Content
    var title: LocalizedStringKey

    init(title: LocalizedStringKey = "", content: @escaping () -> Content) {
        self.content = content
        self.title = title
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .foregroundColor(colorScheme == .dark ? .black : .white)
                .frame(height: panelTitleHeight)
                .zIndex(2)

            HStack {
                Text(title).font(.subheadline)
                Spacer()
            }
            .padding(.horizontal, 8)
            .frame(height: panelTitleHeight)
            .background(Color(NSColor.separatorColor).opacity(0.4))
            .zIndex(3)

            content()
                .zIndex(1)
                .padding(.top, panelTitleHeight)
                .frame(maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .background(Color(NSColor.controlBackgroundColor))
        }
    }
}

struct Panel_Previews: PreviewProvider {
    static var previews: some View {
        Panel(title: "title") {
            Text("xxxxx")
        }
    }
}
