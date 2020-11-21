//
//  OrionApp.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/21.
//

import SwiftUI

@main
struct OrionApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(
                    minWidth: 0, idealWidth: 320, maxWidth: .infinity,
                    minHeight: 0, idealHeight: 200, maxHeight: .infinity,
                    alignment: .center
                )
        }.windowToolbarStyle(UnifiedCompactWindowToolbarStyle(showsTitle: false))
    }
}
