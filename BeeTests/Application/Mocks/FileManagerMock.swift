//
//  FileManagerMock.swift
//  BeeTests
//
//  Created by Daniel Bernal on 8/11/20.
//

import Foundation

class FileManagerMock: FileManager {

    let folderListArray = ["Bee-gucujwpbzrzagfgcontycapchbly",
                            "ModuleCache.noindex",
                            "Sample-alokxtutuawersfxwzvvhwhvggdg",
                            "Sample-ghrpuigpopuhwzgafsyepylglois",
                            "Pods-fsoevwlobpptbrakocmnbazvowxk",
                            "OtherStuff-fuzayqmwfuxuxhglsddisprjqkqa"]
    
    override func contentsOfDirectory(atPath: String) throws -> [String] {
        folderListArray
    }

}
