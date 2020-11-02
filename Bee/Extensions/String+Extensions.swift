//
//  String+Extensions.swift
//  Bee
//
//  Created by Santiago Avila Arroyave on 11/2/20.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: String())
    }
}
