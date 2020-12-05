//
//  LLDBCompileUnit.swift
//  Orion
//
//  Created by Renzhe Zheng on 2020/11/24.
//

struct LLDBCompileUnitModel: Decodable {
    var filePath: String
    var language: String
}

struct LLDBModuleModel: Decodable {
    var moduleName: String
    var compileUnits: [LLDBCompileUnitModel]
}

struct LLDBTargetModel: Decodable {
    var executableName: String
    var targetIndex: Int
    var targetPlatform: String
    var modules: [LLDBModuleModel]
}

struct LLDBSummaryModel: Decodable {
    var targets: [LLDBTargetModel]
}
