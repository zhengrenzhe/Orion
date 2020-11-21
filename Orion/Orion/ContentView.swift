//
//  ContentView.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            HStack {
                Text("XX")
            }.frame(maxWidth: .infinity).background(Color.red)
        }.toolbar(content: {
            ToolbarItemGroup {
                StepCommand()
                Spacer()
                DebuggerState()
                Spacer()
                DebuggerTarget()
            }
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
