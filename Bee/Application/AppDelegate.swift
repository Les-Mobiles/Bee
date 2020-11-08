//
//  AppDelegate.swift
//  Bee
//
//  Created by Daniel Bernal on 30/10/20.
//

import Cocoa
import SwiftUI

protocol AppDelegatable: NSApplicationDelegate {
    var window: NSWindow! {get set}
}

@NSApplicationMain
class AppDelegate: NSObject, AppDelegatable {
    
    var window: NSWindow!
    var menuBarConfigurator: MenuBarHandler!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        menuBarConfigurator = MenuBarHandler(appDelegate: self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}


