//
//  BuildSummary.swift
//  Bee
//
//  Created by Daniel Bernal on 1/11/20.
//

import Foundation

struct BuildSummary: Codable {
    
    let machineName: String
    let warningCount: Int
    let duration: Int
    let signature: String
    let startDate: Date
    let endDate: Date
    let buildStatus: String
    let schema: String
    
}
