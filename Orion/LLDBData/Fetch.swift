//
//  Fetch.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/24.
//

import Alamofire

func fetchSummary(callback: @escaping (LLDBSummaryModel) -> Void) {
    AF.request(summaryAddress).responseDecodable(of: LLDBSummaryModel.self) { res in
        if let val = res.value {
            callback(val)
        }
    }
}
