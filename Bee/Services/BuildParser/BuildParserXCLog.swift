//
//  BuildParserXCLog.swift
//  Bee
//
//  Created by Daniel Bernal on 30/10/20.
//

import Foundation
import PermissionsKit

struct LogParserXCLog {
    
    // MARK: LogParser Protocol
    var derivedDataPath: String = "/Users/afterxleep/Library/Developer/Xcode/DerivedData"
    
    // MARK: Static vars
    private let shell = "/bin/bash"
    private let parserExecutable = "xclogparser"
    private let simpleReportCommand = "%@ parse --project %@ --reporter summaryJson --derived_data %@"
    
    func shell(_ command: String) -> String {
        let task = Process()
        let pipe = Pipe()

        task.standardOutput = pipe
        task.arguments = ["-c", command]
        task.launchPath = shell
        task.launch()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)!

        return output
    }

}

// MARK: LogParser Protocol
extension LogParserXCLog: LogParser {

    init(withLogPath path: String) {
        self.derivedDataPath = path
    }
    
    func parseLogs(forProject project: String) -> Result<[BuildSummary], LogParserError> {
                
        guard let parser = Bundle.main.path(forResource: parserExecutable,
                                            ofType: nil) else { return .failure(.parserNotFound) }
        
        // Make sure we have permissions to full disk access
        guard PermissionsKit.authorizationStatus(for: .fullDiskAccess) == .authorized else { return .failure(.filePermissionError)}
                
        let result = shell(String(format: simpleReportCommand, parser, project, derivedDataPath))
        
        print(result)
        return .success([])
    }

}
