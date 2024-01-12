//
//  LocalStorage.swift
//  ForceDefaultLanguage
//
//  Created by Madalin Zaharia on 11.01.2024.
//

import Foundation

public class LocalStorage {
    private let userDefaults: UserDefaults = .standard
    
    private let currentAppLocaleKey = "current-app-locale-key"
    
    public var currentAppLocale: String { // language
        get { (userDefaults.value(forKey: currentAppLocaleKey) as? String) ?? Locale.current.languageCode ?? "en" }
        set { userDefaults.set(newValue, forKey: currentAppLocaleKey) }
    }
}
