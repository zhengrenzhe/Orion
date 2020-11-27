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

                self.targets?.forEach { target in
                    target.modules.forEach { module in
                        module.compileUnits.forEach { unit in
                            DispatchQueue.global(qos: .background).async {
                                FileStore.loadFile(filePath: unit.filePath)
                            }
                        }
                    }
                }
            }
        }
    }
}
