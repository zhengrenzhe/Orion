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
            SourceCode()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.red)
            DisassembleCode()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.green)
            VStack {
                Register()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.pink)
                Variables()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.purple)
                BreakPoints()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.yellow)
                Threads()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.blue)
            }.frame(width: 270)
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
