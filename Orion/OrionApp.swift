//
//  OrionApp.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/21.
//

import SwiftUI

@main
struct OrionApp: App {
    init() {
        connectLLDB()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
//                .preferredColorScheme(.dark)
                .frame(
                    minWidth: 0, idealWidth: 320, maxWidth: .infinity,
                    minHeight: 0, idealHeight: 200, maxHeight: .infinity,
                    alignment: .center
                )
        }.windowToolbarStyle(UnifiedCompactWindowToolbarStyle(showsTitle: false))
    }
}
