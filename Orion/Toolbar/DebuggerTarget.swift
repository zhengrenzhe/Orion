//
//  DebuggerTarget.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/21.
//

import SwiftUI

struct DebuggerTarget: View {
    var body: some View {
        HStack {
            Picker(selection: .constant(1), label: Text("Picker"), content: {
                Text("/Users/zhensxdbgui/func").tag(1)
                Text("/Users/zhengrenzhe/Code/lldbgui/func").tag(2)
            })
                .frame(maxWidth: 200, alignment: .leading)
                .help("debug-target")
            CommandButton(title: "add-debug-target") {
                Image(systemName: "plus")
            }
        }
    }
}

struct DebuggerTarget_Previews: PreviewProvider {
    static var previews: some View {
        DebuggerTarget()
    }
}
