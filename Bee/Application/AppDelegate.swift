//
//  AppDelegate.swift
//  Bee
//
//  Created by Daniel Bernal on 30/10/20.
//

import Cocoa
import SwiftUI
import ServiceManagement


protocol AppDelegatable: NSApplicationDelegate {
    var window: NSWindow! {get set}
}

@NSApplicationMain
class AppDelegate: NSObject, AppDelegatable {
    
    var window: NSWindow!
    var menuBarConfigurator: MenuBarHandler!
    var preferences: PreferencesDisplayable!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let launcherAppId = "com.banshai.BeeLauncher"
        let runningApps = NSWorkspace.shared.runningApplications
        let isRunning = !runningApps.filter { $0.bundleIdentifier == launcherAppId }.isEmpty
        SMLoginItemSetEnabled(launcherAppId as CFString, true)
        if isRunning {
            DistributedNotificationCenter.default().post(name: .killLauncher, object: Bundle.main.bundleIdentifier!)
        }
        window = NSWindow(
                     contentRect: NSRect(x: 0, y: 0, width: 400, height: 300),
                     styleMask: [.titled, .closable, .miniaturizable],
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


extension Notification.Name {
    static let killLauncher = Notification.Name("killLauncher")
}
