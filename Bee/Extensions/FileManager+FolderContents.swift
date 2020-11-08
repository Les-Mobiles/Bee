//
//  FileManager+FolderContents.swift
//  Bee
//
//  Created by Daniel Bernal on 4/11/20.
//

import Foundation

extension FileManager {
    
    func folderContents(for directory: String, skipsHiddenFiles: Bool = true ) -> [String]? {
        do {
            let fileURLs = try self.contentsOfDirectory(atPath: directory)
            return fileURLs
        } catch {
            return nil
        }
    }
}
