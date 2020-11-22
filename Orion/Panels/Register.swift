//
//  Register.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/21.
//

import SwiftUI

struct Register: View {
    var body: some View {
        Panel(title: "registers") {
            VStack {
                CommandButton(title: "continue") {
                    Image(systemName: "play.fill")
                }
            }
        }
    }
}

struct Register_Previews: PreviewProvider {
    static var previews: some View {
        Register()
    }
}
