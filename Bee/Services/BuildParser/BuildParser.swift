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

extension LogParserError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .parserNotFound:
            return "Error.ParserExecutableNotFound".localized
        case .errorDecodingParserData:
            return "Error.DecodingOutput".localized
        case .projectNotFound:
            return "Error.XCodeProjectNotFound".localized
        case .invalidFolderSelected:
            return "Error.LogParserHasNoAccess".localized
        case .generalError:
            return "Error.unknown".localized
        }
    }
}


protocol LogParser {    
    func parseLogs(forProject project: String,
                   withData derivedData: String) -> Result<BuildSummary?, LogParserError>
}
