//
//  PreferencesView.swift
//  Bee
//
//  Created by Daniel Bernal on 30/10/20.
//

import SwiftUI

struct PreferencesView: View {
    
    @ObservedObject private(set) var viewModel: PreferencesViewModel
    weak var controller: PreferencesDisplayable?
    
    var body: some View {
        VStack(alignment: .leading, spacing: Constants.twenty.rawValue) {
            HStack {
                Text("Preferences.ServerURL")
                TextField("Preferences.ServerURL", text: $viewModel.serverURL)
            }
            HStack {
                Picker("Preferences.DerivedData", selection: $viewModel.derivedDataPath) {
                    ForEach(DerivedDataPathOptions.allCases) { Text($0.rawValue) }
                }
                .onReceive([viewModel.derivedDataPath].publisher.first(), perform: { path in
                    controller?.openFinder(atPath: path)
                })
                .frame(width: 180, height: 20)
                .fixedSize(horizontal: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, vertical: false)
            }
            HStack {
                Toggle("Preferences.LaunchAtLogin", isOn: $viewModel.lauchAtLogin)
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
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView(viewModel: PreferencesViewModel())
    }
}
