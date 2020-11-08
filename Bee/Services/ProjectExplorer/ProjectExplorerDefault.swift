//
//  ProjectExplorerDefault.swift
//  Bee
//
//  Created by Daniel Bernal on 3/11/20.
//

import Foundation

struct ProjectExplorerDefault: ProjectExplorer {
    
    var fileManager: FileManager!
    
    init(fileManager: FileManager = FileManager.default) {
        self.fileManager = fileManager
    }
    
    
    func availableProjects(inPath path: String) -> Result<[String], ProjectExplorerError> {
        return .success([""])
    }
    
    
}
