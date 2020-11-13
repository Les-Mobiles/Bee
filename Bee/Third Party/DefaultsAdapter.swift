//
//  DefaultsAdapter.swift
//  Bee
//
//  Created by Santiago Avila Arroyave on 11/11/20.
//

import Foundation
import Defaults

protocol DefaultsAdapterProtocol {
    static var firstLauch: Bool {get set}
    static var launchAtLogin: Bool {get set}
    static var derivedDataPath: String {get set}
    static var serverURL: String {get set}
}

struct DefaultsAdapter: DefaultsAdapterProtocol {
    
    static var firstLauch: Bool {
        get {
            Defaults[.firstLaunch]
        }
        set {
            Defaults[.firstLaunch] = newValue
        }
    }
    
    static var launchAtLogin: Bool {
        get {
            Defaults[.launchAtLogin]
        }
        set {
            Defaults[.launchAtLogin] = newValue
        }
    }
    
    static var derivedDataPath: String {
        get {
            Defaults[.derivedDataPath]
        }
        set {
            Defaults[.derivedDataPath] = newValue
        }
    }
    
    static var serverURL: String {
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
