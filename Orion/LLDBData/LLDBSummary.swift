//
//  LLDBSummary.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/24.
//

import Combine
import Foundation
import SwiftUI

class LLDBSummary: ObservableObject {
    @Published var content: LLDBSummaryModel?
    @Published var currentTargetIndex = 0

    init() {
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { _ in
            fetchSummary { summary in
                self.content = summary
            }
        }
    }
}
