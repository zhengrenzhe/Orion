//
//  LLDBSummary.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/24.
//

import Combine
import SwiftEventBus
import SwiftUI

class LLDBSummary: ObservableObject {
    // has debug target
    @Published var hasTarget = false
    // debug targets
    @Published var targets: [LLDBTargetModel]?

    init() {
        SwiftEventBus.onMainThread(self, name: clearData) { _ in
            self.hasTarget = false
            self.targets?.removeAll()
        }

        Timer.scheduledTimer(withTimeInterval: fetchFrequency, repeats: true) { _ in
            fetchSummary { summary in
                self.hasTarget = !summary.targets.isEmpty
                self.targets = summary.targets

                self.targets?.forEach { target in
                    target.modules.forEach { module in
                        module.compileUnits.forEach { unit in
                            print("find file \(unit.filePath)")
                            DispatchQueue.global(qos: .background).async {
                                sharedFileStore.loadFile(filePath: unit.filePath)
                            }
                        }
                    }
                }
            }
        }
    }
}
