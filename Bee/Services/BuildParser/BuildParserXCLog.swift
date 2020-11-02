//
//  BuildParserXCLog.swift
//  Bee
//
//  Created by Daniel Bernal on 30/10/20.
//

import Foundation

enum ShellCmdError: Error {
    case invalidArguments
}

struct LogParserXCLog {
    
    // MARK: Static vars
    private let shell = "/bin/bash"
    private let parserExecutable = "xclogparser"
    private let simpleReportCommand = "%@ parse --project %@ --reporter summaryJson --derived_data %@"
    private let unrecognizedArgs = "Unrecognized Arguments"
    private let projectNotFound = "There is no directory for the project"
    
    private func shell(_ command: String) -> Result<Data, ShellCmdError> {
        let task = Process()
        let outputPipe = Pipe()
        let errorPipe = Pipe()

        task.standardOutput = outputPipe
        task.standardError = errorPipe
        task.arguments = ["-c", command]
        task.launchPath = shell
        task.launch()
        
        let parsedData = outputPipe.fileHandleForReading.readDataToEndOfFile()
        let error = errorPipe.fileHandleForReading.readDataToEndOfFile()
        
        if(!error.isEmpty) {
            let e = String(data: error, encoding: .utf8)
            if((e?.contains(unrecognizedArgs)) != nil) {
                return .failure(.invalidArguments)
            }
        }
        return .success(parsedData)
    }
    
    private func handleXCLogParserError(_ data: Data) -> LogParserError {
        let e = String(data: data, encoding: .utf8)
        if((e?.contains(projectNotFound)) != nil) {
            return .projectNotFound
        }
        return .generalError
    }
    
    private func handleShellError(_ error: ShellCmdError) -> LogParserError {
        switch error {
            case .invalidArguments:
                return .invalidFolderSelected
            }
    }

}

// MARK: LogParser Protocol
extension LogParserXCLog: LogParser {
    
    func parseLogs(forProject project: String,
                   withData derivedData: String) -> Result<BuildSummary?, LogParserError> {
                
        guard let parser = Bundle.main.path(forResource: parserExecutable,
                                            ofType: nil) else { return .failure(.parserNotFound) }
                            
        let parserResult = shell(String(format: simpleReportCommand, parser, project, derivedData))
        
        switch parserResult {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let report = try decoder.decode(BuildSummary.self, from: data)
                    return .success(report)
                } catch {
                    return .failure(handleXCLogParserError(data))
                }
                
            case .failure(let error):
                return .failure(handleShellError(error))
        }
    }
}
