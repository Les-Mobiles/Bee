//
//  ContentView.swift
//  Bee
//
//  Created by Daniel Bernal on 30/10/20.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        let parser = LogParserXCLog()
        let derivedData = promptForWorkingDirectoryPermission()
        let result = parser.parseLogs(forProject: "Bee", withData: derivedData?.path ?? "/")
        print(result)
    }
    
    private func promptForWorkingDirectoryPermission() -> URL? {
        let openPanel = NSOpenPanel()
        openPanel.message = "Choose your Derived Data Directory"
        openPanel.prompt = "Choose"
        openPanel.allowedFileTypes = ["none"]
        openPanel.allowsOtherFileTypes = false
        openPanel.canChooseFiles = false
        openPanel.canChooseDirectories = true
        openPanel.showsHiddenFiles = true
        openPanel.runModal()        
        return openPanel.urls.first
    }
    
    var body: some View {
        Text("Welcome to Bee!")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
