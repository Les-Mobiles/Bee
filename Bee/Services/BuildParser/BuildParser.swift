//
//  BuildParser.swift
//  Bee
//
//  Created by Daniel Bernal on 30/10/20.
//

import Foundation

enum LogParserError: Error {
    case parserNotFound
    case generalError
}


protocol LogParser {
    var logPath: String { get } // Path to derived Data
    init(withLogPath path: String)
    func parseLogs() -> Result<Data, LogParserError>
}
