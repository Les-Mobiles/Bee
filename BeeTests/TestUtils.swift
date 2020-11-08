//
//  TestUtils.swift
//  BeeTests
//
//  Created by Daniel Bernal on 8/11/20.
//

import Foundation

struct TestUtils {
    
    static func userHomeDirectory() -> URL? {
        guard let pw = getpwuid(getuid()) else { return nil }
        return URL(fileURLWithFileSystemRepresentation: pw.pointee.pw_dir, isDirectory: true, relativeTo: nil)
    }
}
