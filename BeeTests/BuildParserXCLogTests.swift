//
//  BuildParserXCLogTests.swift
//  BeeTests
//
//  Created by Daniel Bernal on 1/11/20.
//

import XCTest
@testable import Bee

class BuildParserXCLogTests: XCTestCase {

    private enum Constants: String {
        case derivedDataPath = "/Library/Developer/Xcode/DerivedData/"
        case derivedDataPathInvalidArgs = "/Library/Developer/"
        case projectName = "Bee"
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBuildParserSuccess() throws {
        let parser = LogParserXCLog()
        guard let derivedDataDir = TestUtils.userHomeDirectory()?.path.appending(Constants.derivedDataPath.rawValue) else { return }
        let result = parser.parseLogs(forProject: Constants.projectName.rawValue, withData: derivedDataDir)
        var duration: Float = 0
        switch result {
            case .success(let summary):
                duration = summary?.duration ?? 0.0
            default:
                XCTFail()
        }
        XCTAssertTrue(duration > 0, "Duration should be more than 0")
    }
    
    func testBuildParserErrorProjectNotFound() {
        let parser = LogParserXCLog()
        let derivedDataDir = ""
        let result = parser.parseLogs(forProject: Constants.projectName.rawValue, withData: derivedDataDir)
        var parserError: LogParserError = .generalError
        switch result {
            case .success(_):
                XCTFail()                
            case .failure(let error):
                parserError = error
        }
        XCTAssertEqual(parserError, LogParserError.invalidFolderSelected)
    }

}