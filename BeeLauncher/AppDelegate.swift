//
//  AppDelegate.swift
//  BeeLauncher
//
//  Created by Santiago Avila Arroyave on 11/14/20.
//

import Cocoa
import SwiftUI

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let mainAppId = "com.banshai.Bee"
        let runningApps = NSWorkspace.shared.runningApplications
        let beeIsRunning = !runningApps.filter { $0.bundleIdentifier == mainAppId }.isEmpty
        
        if !beeIsRunning {
            DistributedNotificationCenter.default().addObserver(self, selector: #selector(terminate), name: .killLauncher, object: mainAppId)
            guard let url = NSWorkspace.shared.urlForApplication(withBundleIdentifier: mainAppId) else { return }

            NSWorkspace.shared.openApplication(at: url, configuration: NSWorkspace.OpenConfiguration(), completionHandler: nil)
        } else {
            terminate()
        }
    }
    
    @objc func terminate() {
        NSApp.terminate(nil)
    }
}

extension Notification.Name {
    static let killLauncher = Notification.Name("killLauncher")
}
