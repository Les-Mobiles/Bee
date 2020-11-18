//
//  PreferencesViewModel.swift
//  Bee
//
//  Created by Santiago Avila Arroyave on 11/16/20.
//

import Foundation

enum DerivedDataPathOptions: String, CaseIterable, Identifiable {
    case `default` = "Default"
    case custom = "Custom"
    
    var id: String { rawValue }
    
    var path: String {
        switch self {
            case .default:
                return "Developer/Xcode/DerivedData"
            case .custom:
                return String()
        }
    }
}

final class PreferencesViewModel: ObservableObject {
    
    @Published var serverURL: String {
        didSet {
            storage.serverURL = serverURL
        }
    }
    
    @Published var derivedDataPath: String {
        didSet {
            storage.derivedDataPath = derivedDataPath
        }
    }

    @Published var lauchAtLogin: Bool {
        didSet {
            storage.launchAtLogin = lauchAtLogin
        }
    }

    private var storage: Storage
    
    init(storage: Storage = StorageDefault()) {
        self.storage = storage
        self.serverURL = storage.serverURL
        self.derivedDataPath = storage.derivedDataPath
        self.lauchAtLogin = storage.launchAtLogin
    }
}



