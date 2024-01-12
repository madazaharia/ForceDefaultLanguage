//
//  StringExtensions.swift
//  ForceDefaultLanguage
//
//  Created by Madalin Zaharia on 11.01.2024.
//

import Foundation

extension String {
    
    public var localized: String { // in the application languages
        return NSLocalizedString(self, comment: "")
    }
}
