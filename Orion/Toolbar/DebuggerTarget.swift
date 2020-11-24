//
//  DebuggerTarget.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/21.
//

import SwiftUI

struct DebuggerTarget: View {
    @EnvironmentObject private var LLDBSummary: LLDBSummary

    var body: some View {
        HStack {
            Picker(selection: $LLDBSummary.currentTargetIndex, label: Text("debug-target"), content: {
                if let targets = LLDBSummary.content?.targets {
                    ForEach(targets, id: \.targetIndex) { target in
                        Text("\(target.executableName)").tag("\(target.targetIndex)")
                    }
                } else {
                    Text("/Users/zhengrenzhe/Code/Orion/debug_code/a.out").tag(1)
                }
            })
                .frame(maxWidth: .infinity, alignment: .leading)
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
