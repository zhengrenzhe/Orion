//
//  ContentView.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(spacing: 0) {
            HSplitView {
                SourceCode()
                    .frame(minWidth: 100, maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.red)
                    .layoutPriority(1)
                DisassembleCode()
                    .frame(minWidth: 100, maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.green)
                    .layoutPriority(1)
            }
            VSplitView {
                Register()
                    .frame(maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                    .background(Color.pink)
                Variables()
                    .frame(maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                    .background(Color.purple)
                BreakPoints()
                    .frame(maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                    .background(Color.yellow)
                Threads()
                    .frame(maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                    .background(Color.blue)
            }.frame(width: 270).fixedSize(horizontal: true, vertical: false)
                .layoutPriority(0)
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
