//
//  BuildParserXCLog.swift
//  Bee
//
//  Created by Daniel Bernal on 30/10/20.
//

import Foundation

struct LogParserXCLog {
    
    // LogParser Protocol Vars
    var logPath: String = "/Library/Developer/Xcode/DerivedData"
    
    private let parserPath = "xclogparser"

    private func validateParserPath(path: String) -> Bool {
        guard Bundle.main.path(forResource: parserPath, ofType: "") != nil else { return false }
        return true
    }

}

extension LogParserXCLog: LogParser {
    
    init(withLogPath path: String) {
        self.logPath = path
    }
    
    func parseLogs() -> Result<Data, LogParserError> {
        if(!validateParserPath(path: parserPath)) {
            return .failure(.parserNotFound)
        }        
        return .success(Data())
    }
    
}
