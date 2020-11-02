//
//  BuildParser.swift
//  Bee
//
//  Created by Daniel Bernal on 30/10/20.
//

import Foundation

enum LogParserError: Error {
    case parserNotFound
    case errorDecodingParserData
    case projectNotFound
    case invalidFolderSelected
    case generalError
}


protocol LogParser {    
    func parseLogs(forProject project: String,
                   withData derivedData: String) -> Result<BuildSummary?, LogParserError>
}
