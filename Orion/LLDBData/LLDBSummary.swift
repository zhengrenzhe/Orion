//
//  LLDBSummary.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/24.
//

import Combine
import SwiftUI

class LLDBSummary: ObservableObject {
    // has debug target
    @Published var hasTarget = false
    // debug targets
    @Published var targets: [LLDBTargetModel]?

    init() {
        Timer.scheduledTimer(withTimeInterval: fetchFrequency, repeats: true) { _ in
            fetchSummary { summary in
                self.hasTarget = !summary.targets.isEmpty
                self.targets = summary.targets
            }
        }
    }
}
