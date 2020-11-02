//
//  MenuBarHandlerTests.swift
//  BeeTests
//
//  Created by Santiago Avila Arroyave on 11/2/20.
//

import XCTest
@testable import Bee

class MenuBarHandlerTests: XCTestCase {

    func testInit_menuBarHandler_statusItemShouldHaveMenuItems() {
        let menuBarHandler = MenuBarHandler()
        let expectedMenuItems = 4
        
        XCTAssertNotNil(menuBarHandler.statusItem)
        XCTAssertNotNil(menuBarHandler.statusItem.button)
        XCTAssertNotNil(menuBarHandler.statusItem.menu)
        
        let menu = menuBarHandler.statusItem.menu!
        XCTAssertEqual(menu.items.count, expectedMenuItems)
    }
}
