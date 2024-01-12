//
//  LanguageSelectionViewModel.swift
//  ForceDefaultLanguage
//
//  Created by Madalin Zaharia on 11.01.2024.
//

import Foundation

extension LanguageSelectionView {
    class ViewModel: ObservableObject {
        
        @Published private(set) var items: [LanguageItem] = []
        @Published var selectedItem: LanguageItem?
        
        private var locales = ["en", "fr", "sk"] // supported languages
        private var localStorage: LocalStorage
        
        init(localStorage: LocalStorage) {
            self.localStorage = localStorage
        }
        
        // MARK: - Functions
        func getItems() {
            items.removeAll()
            
            for locale in locales {
                var identifier = ""
                
                let previousLocale = localStorage.currentAppLocale
                let currentLocale = Locale.current.languageCode ?? "en"
                if previousLocale != currentLocale { // the user changed the language in the application settings
                    let defaultLocalization = Bundle.main.infoDictionary!["CFBundleDevelopmentRegion"] as! String
                    identifier = defaultLocalization
                } else {
                    identifier = String(Locale.preferredLanguages[0].prefix(2))
                }

                if let languageName = Locale(identifier: identifier).localizedString(forLanguageCode: locale) {
                    items.append(
                        LanguageItem(
                            title: languageName.capitalized,
                            type: "\(locale)"
                        )
                    )
                }
            }
        }

        func getCurrentLanguage() {
            var languagePrefix = String(Locale.preferredLanguages[0].prefix(2))
            /// There is no event, because changing the language will kill all running apps.
            /// So when the app is started again you can detect if the language is switched if you save the previous language some where.
            /// I save current language locally

            let previousLocale = localStorage.currentAppLocale
            let currentLocale = Locale.current.languageCode ?? "en"
            if previousLocale != currentLocale { // the user changed the language in the application settings
                let defaultLocalization = Bundle.main.infoDictionary!["CFBundleDevelopmentRegion"] as! String
                languagePrefix = defaultLocalization
            } else if !locales.contains(localStorage.currentAppLocale) { // force `en` language
                localStorage.currentAppLocale = "en"
                languagePrefix = "en"
            } else {
                localStorage.currentAppLocale = String(languagePrefix)
            }

            selectedItem = items.first(where: { $0.type == languagePrefix })
        }
    }
}
