//
//  PreferencesView.swift
//  Bee
//
//  Created by Daniel Bernal on 30/10/20.
//

import SwiftUI

struct PreferencesView: View {
    
    @State private var serverURL = String()
    @State private var lauchAtLogin = false
    @State private var derivedDataPath = String()
        
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.twenty.rawValue) {
            HStack {
                Text("Preferences.ServerURL")
                TextField("Preferences.ServerURL", text: $serverURL)
                
            }
            HStack {
                Picker("Preferences.DerivedData", selection: $derivedDataPath) {
                    ForEach(DerivedDataPathOptions.allCases) {
                        Text($0.rawValue)
                    }
                }
            }
            HStack {
                Toggle("Preferences.LaunchAtLogin", isOn: $lauchAtLogin)
            }
        }.padding(Constants.defaultPadding)
    }
}

private extension PreferencesView {
    enum Constants: CGFloat, RawRepresentable {
        typealias RawValue = CGFloat
        case twenty = 20
        
        static let defaultPadding = EdgeInsets(
            top: Constants.twenty.rawValue,
            leading: Constants.twenty.rawValue,
            bottom: Constants.twenty.rawValue,
            trailing: Constants.twenty.rawValue
        )
    }
    
    enum DerivedDataPathOptions: String, CaseIterable, Identifiable {
        case `default` = "Default"
        case custom = "Custom"
        
        var id: String { rawValue }
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
