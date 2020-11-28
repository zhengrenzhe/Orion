//
//  InnerState.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/25.
//

import Combine
import SwiftEventBus
import SwiftUI

class InnerState: ObservableObject {
    // is connected to lldb
    @Published var connected = false

    @Published var currentTargetIndex = 0

    init() {
        Timer.scheduledTimer(withTimeInterval: fetchFrequency, repeats: true) { _ in
            fetchPing { connected in
                self.connected = connected
                self.currentTargetIndex = connected ? self.currentTargetIndex : 0

                if !connected {
                    SwiftEventBus.post(clearData)
                }
            }
        }
    }
}
