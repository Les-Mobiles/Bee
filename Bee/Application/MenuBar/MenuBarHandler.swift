//
//  MenuBarHandler.swift
//  Bee
//
//  Created by Santiago Avila Arroyave on 11/1/20.
//

import SwiftUI

class MenuBarHandler: NSObject {

    var statusItem: NSStatusItem!
    private weak var appDelegate: AppDelegatable?

    init(appDelegate: AppDelegatable) {
        super.init()
        self.appDelegate = appDelegate
        buildStatusItem()
    }
 }

private extension MenuBarHandler {
    enum MenuItem: CaseIterable {
        case preferences
        case quit

        var title: String {
            switch self {
                case .preferences:
                    return "StatusItem.Menu.Preferences".localized
                case .quit:
                    return "StatusItem.Menu.Quit".localized
            }
         }

        var action: Selector {
            switch self {
                case .preferences:
                    return #selector(presentSettings)
                case .quit:
                    return #selector(NSApplication.terminate(_:))
            }
        }
     }

     @objc func presentSettings() {
         let contentView = ContentView()
         let window = NSWindow(
             contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
             styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
             backing: .buffered, defer: false)

         appDelegate?.window = window
         appDelegate?.window.isReleasedWhenClosed = false
         appDelegate?.window.center()
         appDelegate?.window.setFrameAutosaveName("Main Window")
         appDelegate?.window.contentView = NSHostingView(rootView: contentView)
         appDelegate?.window.makeKeyAndOrderFront(nil)
     }

    func buildStatusItem() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem.button {
            button.title = "Bee"
        }
        statusItem.menu = menu()
     }

     func menu() -> NSMenu {
         let menu = NSMenu()
         MenuItem.allCases.forEach {
             let item = NSMenuItem(title: $0.title, action: $0.action, keyEquivalent: "")
             if $0 == .preferences {
                 item.target = self
             }
             menu.addItem(item)
             menu.addItem(NSMenuItem.separator())
         }
         return menu
     }
 }
