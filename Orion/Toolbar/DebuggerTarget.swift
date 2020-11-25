//
//  DebuggerTarget.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/21.
//

import SwiftUI

struct DebuggerTarget: View {
    @EnvironmentObject private var LLDBSummary: LLDBSummary
    @EnvironmentObject private var INNERState: InnerState

    private var showTargets: Binding<Bool> { Binding(
        get: { INNERState.connected && LLDBSummary.hasTarget },
        set: { _ in }
    )
    }

    var body: some View {
        HStack {
            Picker(selection: $INNERState.currentTargetIndex, label: Text("debug-target"), content: {
                if showTargets.wrappedValue {
                    if let targets = LLDBSummary.targets {
                        ForEach(targets, id: \.targetIndex) { target in
                            Text("\(target.executableName)").tag("\(target.targetIndex)")
                        }
                    }
                } else {
                    Text("no-target").tag(INNERState.currentTargetIndex)
                }

            })
                .frame(maxWidth: .infinity, alignment: .leading)
                .help("debug-target")
                .disabled(!showTargets.wrappedValue)
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
