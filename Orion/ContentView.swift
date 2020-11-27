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
                Files()
                    .frame(minWidth: 100, maxWidth: .infinity, maxHeight: .infinity)
                    .layoutPriority(1)
                SourceCode()
                    .frame(minWidth: 100, maxWidth: .infinity, maxHeight: .infinity)
                    .layoutPriority(1)
                DisassembleCode()
                    .frame(minWidth: 100, maxWidth: .infinity, maxHeight: .infinity)
                    .layoutPriority(1)
            }
            Divider()
            VSplitView {
                Register()
                    .frame(maxWidth: .infinity, minHeight: panelTitleHeight, maxHeight: .infinity)
                    .layoutPriority(1)
                Variables()
                    .frame(maxWidth: .infinity, minHeight: panelTitleHeight, maxHeight: .infinity)
                    .layoutPriority(1)
                BreakPoints()
                    .frame(maxWidth: .infinity, minHeight: panelTitleHeight, maxHeight: .infinity)
                    .layoutPriority(1)
                Threads()
                    .frame(maxWidth: .infinity, minHeight: panelTitleHeight, maxHeight: .infinity)
                    .layoutPriority(1)
            }
            .frame(width: 270)
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
