//
//  ProjectExplorerDefault.swift
//  Bee
//
//  Created by Daniel Bernal on 3/11/20.
//

import Foundation

struct ProjectExplorerDefault: ProjectExplorer {
    
    var fileManager: FileManager!

    enum StringConstants: String {
        case projectDelimiter = "-"
    }
    
    init(fileManager: FileManager = FileManager.default) {
        self.fileManager = fileManager
    }
    
    func availableProjects(inPath path: String) -> Result<[String], ProjectExplorerError> {
        var fileURLs = [String]()
        do {
            fileURLs = try fileManager.contentsOfDirectory(atPath: path)
        } catch {
            return .failure(.generalError)
        }
        let projects = fileURLs.filter { $0.contains(StringConstants.projectDelimiter.rawValue) }
        let projectNames: [String] = projects.map {
            guard let index = $0.firstIndex(of: Character(StringConstants.projectDelimiter.rawValue)) else { return $0 }
            return String($0.prefix(upTo: index))
        }
        return .success(projectNames)
    }
    
}
