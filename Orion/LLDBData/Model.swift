//
//  LLDBCompileUnit.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/24.
//

struct LLDBCompileUnitModel: Decodable {
    let filePath: String
    let language: String
}

struct LLDBModuleModel: Decodable {
    let moduleName: String
    let compileUnits: [LLDBCompileUnitModel]
}

struct LLDBTargetModel: Decodable {
    let executableName: String
    let targetIndex: Int
    let targetPlatform: String
    let modules: [LLDBModuleModel]
}

struct LLDBSummaryModel: Decodable {
    let targets: [LLDBTargetModel]
}
