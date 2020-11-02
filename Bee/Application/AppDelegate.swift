//
//  AppDelegate.swift
//  Bee
//
//  Created by Daniel Bernal on 30/10/20.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    var menuBarConfigurator: MenuBarHandler!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        menuBarConfigurator = MenuBarHandler()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

