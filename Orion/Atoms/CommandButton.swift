//
//  CommandButton.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/21.
//

import SwiftUI

struct CommandButton<Content: View>: View {
    var content: () -> Content
    var title: LocalizedStringKey

    init(title: LocalizedStringKey = "", content: @escaping () -> Content) {
        self.content = content
        self.title = title
    }

    var body: some View {
        Button(action: {}, label: {
            content()
                .font(.title2)
                .offset(y: 2)
                .padding(.horizontal, 2)
        }).help(title)
    }
}

struct CommandButton_Previews: PreviewProvider {
    static var previews: some View {
        CommandButton {
            Image(systemName: "play.fill")
        }
    }
}
