//
//  DebuggerState.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/21.
//

import SwiftUI

struct DebuggerState: View {
    var body: some View {
        Text("Hello, World!")
            .frame(width: 420, alignment: .leading)
            .font(.system(size: 12, weight: .light, design: .rounded))
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .background(Color.gray.opacity(0.15))
            .cornerRadius(5)
    }
}

struct DebuggerState_Previews: PreviewProvider {
    static var previews: some View {
        DebuggerState()
    }
}
