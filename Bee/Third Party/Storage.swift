//
//  Storage.swift
//  Bee
//
//  Created by Santiago Avila Arroyave on 11/11/20.
//

import Foundation
import Defaults

protocol Storage {
    var firstLauch: Bool {get set}
    var launchAtLogin: Bool {get set}
    var derivedDataPath: String {get set}
    var serverURL: String {get set}
}

struct StorageDefault: Storage {
    
    var firstLauch: Bool {
        get {
            Defaults[.firstLaunch]
        }
        set {
            Defaults[.firstLaunch] = newValue
        }
    }
    
    var launchAtLogin: Bool {
        get {
            Defaults[.launchAtLogin]
        }
        set {
            Defaults[.launchAtLogin] = newValue
        }
    }
    
    var derivedDataPath: String {
        get {
            Defaults[.derivedDataPath]
        }
        set {
            Defaults[.derivedDataPath] = newValue
        }
    }
    
    var serverURL: String {
        get {
            Defaults[.serverURL]
        }
        set {
            Defaults[.serverURL] = newValue
        }
    }
}

extension Defaults.Keys {
    
    static let firstLaunch = Key<Bool>(Keys.firstLaunch.value, default: true)
    static let launchAtLogin = Key<Bool>(Keys.launchAtLogin.value, default: false)
    static let derivedDataPath = Key<String>(Keys.derivedDataPath.value, default: String())
    static let serverURL = Key<String>(Keys.serverURL.value, default: String())
    
    enum Keys: String {
        case firstLaunch
        case launchAtLogin
        case derivedDataPath
        case serverURL
        
        var value: String { return rawValue }
    }
}
