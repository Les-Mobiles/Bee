//
//  PreferencesViewController.swift
//  Bee
//
//  Created by Santiago Avila Arroyave on 11/11/20.
//

import Cocoa
import SwiftUI

protocol PreferencesDisplayable {
    func present()
    func presentOnStartupIfNeeded()
}

class PreferencesViewController {
    
    private weak var window: NSWindow?
    private(set) var view: PreferencesView
    
    init(window: NSWindow?,
         view: PreferencesView = .init()) {
        self.window = window
        self.view = view
        window?.contentView = NSHostingView(rootView: view)
    }
}

extension PreferencesViewController: PreferencesDisplayable {
    func present() {
        window?.makeKeyAndOrderFront(nil)
    }
    
    func presentOnStartupIfNeeded() {
        guard DefaultsAdapter.firstLauch else { return }
        DefaultsAdapter.firstLauch = false
        present()
    }
}
