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
    
    private enum StringConstants: String {
        case shell = "/bin/bash"
        case parserExecutable = "xclogparser"
        case simpleReportCommand = "%@ parse --project %@ --reporter summaryJson --derived_data %@"
        case unrecognizedArgs = "Unrecognized Arguments"
        case projectNotFound = "There is no directory for the project"
    }
        
    private func shell(_ command: String) -> Result<Data, ShellCmdError> {
        let task = Process()
        let outputPipe = Pipe()
        let errorPipe = Pipe()

        task.standardOutput = outputPipe
        task.standardError = errorPipe
        task.arguments = ["-c", command]
        task.launchPath = StringConstants.shell.rawValue
        task.launch()
        
        let parsedData = outputPipe.fileHandleForReading.readDataToEndOfFile()
        let parseError = errorPipe.fileHandleForReading.readDataToEndOfFile()
        
        if !parseError.isEmpty {
            let e = String(data: parseError, encoding: .utf8)
            if e?.contains(StringConstants.unrecognizedArgs.rawValue) != nil {
                return .failure(.invalidArguments)
            }
        }
        return .success(parsedData)
    }
    
    private func handleXCLogParserError(_ parseError: Data) -> LogParserError {
        let e = String(data: parseError, encoding: .utf8)
        if e?.contains(StringConstants.projectNotFound.rawValue) != nil {
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
                
        guard let parser = Bundle.main.path(forResource: StringConstants.parserExecutable.rawValue,
                                            ofType: nil) else { return .failure(.parserNotFound) }
                            
        let parserResult = shell(String(format: StringConstants.simpleReportCommand.rawValue, parser, project, derivedData))
        
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
