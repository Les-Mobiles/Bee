//
//  BuildSummary.swift
//  Bee
//
//  Created by Daniel Bernal on 1/11/20.
//

import Foundation

struct BuildSummary: Codable {
    
    let machineName: String?
    let warningCount: Int?
    let duration: Float
    let signature: String?
    let startDate: String?
    let endDate: String?
    let buildStatus: String?
    let schema: String?
    
}
