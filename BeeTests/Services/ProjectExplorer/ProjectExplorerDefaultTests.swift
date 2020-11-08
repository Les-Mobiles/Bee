//
//  BuildParserXCLogTests.swift
//  BeeTests
//
//  Created by Daniel Bernal on 1/11/20.
//

import XCTest
@testable import Bee

class ProjectExplorerDefaultTests: XCTestCase {

    func testAvailableProjects() {
        let fileManager = FileManagerMock()
        let projectExplorer = ProjectExplorerDefault(fileManager: fileManager)
        let folderList = projectExplorer.availableProjects(inPath: "/test/path")
        switch folderList {
        case .success(let results):
            XCTAssertEqual(results, ["Bee", "OtherStuff", "Pods", "Sample"])
        default:
            XCTFail()
        }
    }
}
