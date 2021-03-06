//
//  DebuggerState.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/21.
//

import SwiftUI

struct DebuggerState: View {
    @EnvironmentObject private var INNERState: InnerState

    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .frame(width: 8, height: 8)
                .foregroundColor(INNERState.connected ? Color.green : Color.red)
            Text(INNERState.connected ? "lldb-connected" : "lldb-not-connected")
                .font(.system(size: 12, weight: .light, design: .rounded))
        }
        .frame(width: 300, alignment: .leading)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.gray.opacity(0.15))
        .cornerRadius(5)
        .help("state")
    }
}

struct DebuggerState_Previews: PreviewProvider {
    static var previews: some View {
        DebuggerState()
    }
}
