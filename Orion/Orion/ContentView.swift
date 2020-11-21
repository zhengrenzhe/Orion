//
//  ContentView.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {}.toolbar(content: {
            ToolbarItemGroup {
                StepCommand()
            }
            ToolbarItemGroup {
                DebuggerState()
            }
            ToolbarItemGroup {
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
