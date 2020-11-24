//
//  SettingsView.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/24.
//

import SwiftUI

struct GeneralSettingsView: View {
    @AppStorage("darkMode") private var darkMode = false

    var body: some View {
        Form {
            Text("settings")
        }
        .padding(10)
        .frame(width: 350, height: 100)
    }
}

struct SettingsView: View {
    private enum Tabs: Hashable {
        case general
    }

    var body: some View {
        TabView {
            GeneralSettingsView()
                .tabItem {
                    Label("general", systemImage: "gear")
                }
                .tag(Tabs.general)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
