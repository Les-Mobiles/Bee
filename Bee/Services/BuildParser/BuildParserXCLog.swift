//
//  BuildParserXCLog.swift
//  Bee
//
//  Created by Daniel Bernal on 30/10/20.
//

import Foundation
import PermissionsKit

struct LogParserXCLog {
    
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
    
    func parseLogs(forProject project: String,
                   withData derivedData: String) -> Result<BuildSummary?, LogParserError> {
                
        guard let parser = Bundle.main.path(forResource: parserExecutable,
                                            ofType: nil) else { return .failure(.parserNotFound) }
                    
        // TODO: Parse potential xclogparser errors here -- This assumes parser worked every time
        let result = shell(String(format: simpleReportCommand, parser, project, derivedData))
        
        guard let jsonData = result.data(using: .utf8) else { return .failure(.errorInterpretingParserData) }
        
        let decoder = JSONDecoder()
        do {
            let report = try decoder.decode(BuildSummary.self, from: jsonData)
            return .success(report)
        } catch {
           print(error)
        }
            
        return .failure(.errorDecodingParserData)
    }

}
