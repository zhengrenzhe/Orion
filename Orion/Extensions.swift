//
//  Extensions.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/22.
//

import SwiftUI

extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
