//
//  ProjectExplorer.swift
//  Bee
//
//  Created by Daniel Bernal on 3/11/20.
//

import Foundation

enum ProjectExplorerError: Error {
    case projectsNotFoundInPath
    case generalError
}

extension ProjectExplorerError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .projectsNotFoundInPath:
            return NSLocalizedString("There are no Xcode projects in the provided path", comment: "")
        case .generalError:
            return NSLocalizedString("An unknown error has ocurred", comment: "")
        }
    }
}

protocol ProjectExplorer {
    var fileManager: FileManager! { get set }
    func availableProjects(inPath: String) -> Result<[String], ProjectExplorerError>
}
