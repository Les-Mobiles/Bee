//
//  FileManager+FolderContentsTests.swift
//  BeeTests
//
//  Created by Daniel Bernal on 8/11/20.
//

import Foundation

import XCTest
@testable import Bee

class FileManagerFolderContentsTests: XCTestCase {

    private enum Constants: String {
        case derivedDataPath = "/Library/Developer/Xcode/DerivedData/"
    }
    
    func testGetfolderContents() {
        guard let derivedDataDir = TestUtils.userHomeDirectory()?.path.appending(Constants.derivedDataPath.rawValue) else {
            XCTFail()
            return
        }
        guard let contents = FileManager().folderContents(for: derivedDataDir) else {
            XCTFail()
            return
        }
        XCTAssertTrue(contents.count > 0)
    }
}
