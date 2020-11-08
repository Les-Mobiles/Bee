//
//  ProjectExplorer.swift
//  Bee
//
//  Created by Daniel Bernal on 3/11/20.
//

import Foundation

enum ProjectExplorerError {
    case projectsNotFoundInPath
    case generalError
}

extension ProjectExplorerError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .projectsNotFoundInPath:
            return "Error.ProjectsNotFound".localized
        case .generalError:
            return "Error.Unknown".localized
        }
    }
}

protocol ProjectExplorer {
    var fileManager: FileManager! { get set }
    func availableProjects(inPath: String) -> Result<[String], ProjectExplorerError>
}
