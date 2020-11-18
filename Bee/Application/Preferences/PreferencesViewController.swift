//
//  PreferencesViewController.swift
//  Bee
//
//  Created by Santiago Avila Arroyave on 11/11/20.
//

import Cocoa
import SwiftUI

protocol PreferencesDisplayable: class {
    func present()
    func presentOnStartupIfNeeded()
    func openFinder(atPath path: String?)
}

class PreferencesViewController {
    
    private weak var window: NSWindow?
    private var storage: Storage
    private(set) var view: PreferencesView
    
    init(window: NSWindow?,
         storage: Storage = StorageDefault()) {
        self.window = window
        self.storage = storage
        let viewModel = PreferencesViewModel(storage: self.storage)
        self.view = PreferencesView(viewModel: viewModel)
        self.view.controller = self
        window?.contentView = NSHostingView(rootView: view)
    }
}

extension PreferencesViewController: PreferencesDisplayable {
    func present() {
        window?.makeKeyAndOrderFront(nil)
    }
    
    func presentOnStartupIfNeeded() {
        guard storage.firstLauch else { return }
        storage.firstLauch = false
        present()
    }
    
    func openFinder(atPath path: String?) {
        guard let path = path,
              let option = DerivedDataPathOptions(rawValue: path),
              let url = FileManager.default.urls(for: .allLibrariesDirectory, in: .systemDomainMask).first?.appendingPathComponent(option.path) else {
            return
        }
        
//        NSWorkspace.shared.activateFileViewerSelecting([url])
        let openPanel = NSOpenPanel()
        openPanel.title = "Bee needs"
            openPanel.allowsMultipleSelection = false
            openPanel.canChooseDirectories = true
            openPanel.canCreateDirectories = true
            openPanel.canChooseFiles = false
            openPanel.begin
                { (result) -> Void in
                    if result.rawValue == NSApplication.ModalResponse.OK.rawValue
                    {
                        let url = openPanel.url
//                        storeFolderInBookmark(url: url!)
                    }
            }
//            return openPanel.url
    }
}
