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
    var preferences: PreferencesDisplayable!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window = NSWindow(
                     contentRect: NSRect(x: 0, y: 0, width: 400, height: 300),
                     styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                     backing: .buffered, defer: false)
        window.isReleasedWhenClosed = false
        window.center()
        window.title = "Preferences"
        window.setFrameAutosaveName("Main Window")
        preferences = PreferencesViewController(window: window)
        preferences.presentOnStartupIfNeeded()
        menuBarConfigurator = MenuBarHandler(preferencesViewController: preferences)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}


