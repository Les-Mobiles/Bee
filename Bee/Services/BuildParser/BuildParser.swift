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
            return NSLocalizedString("The parser executable was not found in the path", comment: "")
        case .errorDecodingParserData:
            return NSLocalizedString("An error ocurred while decoding parser output", comment: "")
        case .projectNotFound:
            return NSLocalizedString("The Xcode project was not found in the provided folder", comment: "")
        case .invalidFolderSelected:
            return NSLocalizedString("The LogParsed could not access the provided folder", comment: "")
        case .generalError:
            return NSLocalizedString("An unexpected error ocurred", comment: "")
        }
    }
}


protocol LogParser {    
    func parseLogs(forProject project: String,
                   withData derivedData: String) -> Result<BuildSummary?, LogParserError>
}
