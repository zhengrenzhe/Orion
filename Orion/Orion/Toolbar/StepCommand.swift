//
//  StepCommand.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/21.
//

import SwiftUI

struct StepCommand: View {
    var body: some View {
        HStack {
            CommandButton(title: "continue") {
                Image(systemName: "play.fill")
            }
            CommandButton(title: "step-over") {
                Image(systemName: "arrow.turn.up.right")
            }
            CommandButton(title: "step-into") {
                Image(systemName: "arrow.down.to.line")
            }
            CommandButton(title: "step-out") {
                Image(systemName: "arrow.up.to.line")
            }
        }
    }
}

struct StepCommand_Previews: PreviewProvider {
    static var previews: some View {
        StepCommand()
    }
}
