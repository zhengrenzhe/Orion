//
//  Panel.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/22.
//

import SwiftUI

struct Panel<Content, TitleMore>: View where Content: View, TitleMore: View {
    @Environment(\.colorScheme) var colorScheme

    var titleMore: TitleMore?
    var autoScroll: Bool
    var content: () -> Content
    var title: LocalizedStringKey

    init(title: LocalizedStringKey = "",
         autoScroll: Bool = true,
         titleMore: TitleMore?,
         content: @escaping () -> Content)
    {
        self.content = content
        self.title = title
        self.titleMore = titleMore
        self.autoScroll = autoScroll
    }

    var contentArea: some View {
        VStack(alignment: .leading, spacing: 0) {
            content()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(title).font(.subheadline)
                    Spacer()
                }
                .padding(.horizontal, 8)
                .frame(height: panelTitleHeight)

                if let titleMore = self.titleMore {
                    titleMore
                }
            }.background(Color(NSColor.windowBackgroundColor))

            if autoScroll {
                ScrollView {
                    contentArea
                }
                .background(Color(NSColor.controlBackgroundColor))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                contentArea
            }
        }
    }
}

extension Panel where TitleMore == EmptyView {
    init(title: LocalizedStringKey = "", autoScroll: Bool = true, content: @escaping () -> Content) {
        self.title = title
        self.content = content
        self.autoScroll = autoScroll
    }
}

struct Panel_Previews: PreviewProvider {
    static var previews: some View {
        Panel(title: "title") {
            Text("xxxxx")
        }
    }
}
