//
//  ForceDefaultLanguageApp.swift
//  ForceDefaultLanguage
//
//  Created by Madalin Zaharia on 11.01.2024.
//

import SwiftUI

@main
struct ForceDefaultLanguageApp: App {
    
    private var localStorage = LocalStorage()
    
    init() {
        if localStorage.isFirstLaunch {
            let defaultLocalization = Bundle.main.infoDictionary!["CFBundleDevelopmentRegion"] as! String
            Bundle.main.setLanguage(language: defaultLocalization) // force `sk` default localization from info.plist - custom language value
            
            localStorage.currentAppLocale = defaultLocalization
        } else {
            /// There is no event, because changing the language will kill all running apps.
            /// So when the app is started again you can detect if the language is switched if you save the previous language some where.
            /// I save current language locally
            /// 
            let previousLocale = localStorage.currentAppLocale
            let currentLocale = Locale.current.languageCode ?? "en"
            if previousLocale != currentLocale { // the user changed the language in the application settings
                localStorage.currentAppLocale = currentLocale
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(localStorage: localStorage)
        }
    }
}
