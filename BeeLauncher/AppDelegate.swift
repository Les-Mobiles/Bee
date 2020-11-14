//
//  AppDelegate.swift
//  BeeLauncher
//
//  Created by Santiago Avila Arroyave on 11/13/20.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let mainAppIdentifier = "ccom.banshai.Bee"
        let runningApps = NSWorkspace.shared.runningApplications
        let isRunning = !runningApps.filter { $0.bundleIdentifier == mainAppIdentifier }.isEmpty

        if !isRunning {
            DistributedNotificationCenter.default().addObserver(self, selector: #selector(self.terminate), name: .killLauncher, object: mainAppIdentifier)
            let path = Bundle.main.bundlePath as NSString
            var components = path.pathComponents
            components.removeLast()
            components.removeLast()
            components.removeLast()
            components.append("MacOS")
            components.append("Bee") //main app name

            let newPath = NSString.path(withComponents: components)
            NSWorkspace.shared.launchApplication(newPath)
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
