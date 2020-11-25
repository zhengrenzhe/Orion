//
//  InnerState.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/25.
//

import Combine
import SwiftUI

class InnerState: ObservableObject {
    @Published var connected = false
    @Published var currentTargetIndex = 0

    init() {
        Timer.scheduledTimer(withTimeInterval: fetchFrequency, repeats: true) { _ in
            fetchPing { connected in
                self.connected = connected
            }
        }
    }
}
