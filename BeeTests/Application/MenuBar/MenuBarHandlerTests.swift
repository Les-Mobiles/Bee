//
//  MenuBarHandlerTests.swift
//  BeeTests
//
//  Created by Santiago Avila Arroyave on 11/2/20.
//
import XCTest
@testable import Bee

class MenuBarHandlerTests: XCTestCase {
    
    var appDelegate: AppDelegateMock!

    func testInit_menuBarHandler_statusItemShouldHaveMenuItems() {
        let appDelegate = AppDelegateMock()
        let menuBarHandler = MenuBarHandler(appDelegate: appDelegate)
        let expectedMenuItems = 4
        
        XCTAssertNotNil(menuBarHandler.statusItem)
        XCTAssertNotNil(menuBarHandler.statusItem.button)
        XCTAssertNotNil(menuBarHandler.statusItem.menu)
        
        let menu = menuBarHandler.statusItem.menu!
        XCTAssertEqual(menu.items.count, expectedMenuItems)
    }
}
