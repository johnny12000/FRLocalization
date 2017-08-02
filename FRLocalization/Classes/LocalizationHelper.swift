//
//  LocalizationHelper.swift
//  FRLocalization
//
//  Created by Nikola Ristic on 8/2/17.
//  Copyright © 2017 nr. All rights reserved.
//

import UIKit

let AppleLanguageKey = "AppleLanguages" //swiftlint:disable:this identifier_name

/// Default language. English. If English is unavailable defaults to base localization.
let DefaultLanguage = "en"

/// Manager for localization features of the app.
class LocalizationHelper: NSObject {
    
    let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    /// List available languages
    /// - returns: Array of available languages.
    func availableLanguages(_ excludeBase: Bool = true) -> [String] {
        var availableLanguages = Bundle.main.localizations
        // If excludeBase = true, don't include "Base" in available languages
        if let indexOfBase = availableLanguages.index(of: "Base"), excludeBase == true {
            availableLanguages.remove(at: indexOfBase)
        }
        return availableLanguages
    }
    
    /// Current language
    /// - returns: The current language.
    func currentLanguage() -> String {
        if let currentLanguages = userDefaults.object(forKey: AppleLanguageKey) as? [String],
            let currentLanguage = currentLanguages.first {
            return currentLanguage
        }
        return defaultLanguage()
    }
    
    /// Change the current language
    /// - parameter language: Desired language.
    func setCurrentLanguage(_ language: String) {
        let selectedLanguage = availableLanguages().contains(language) ? language : defaultLanguage()
        if selectedLanguage != currentLanguage() {
            userDefaults.set([language, currentLanguage()], forKey: AppleLanguageKey)
            userDefaults.synchronize()
        }
    }
    
    /// Default language
    /// - returns: The app's default language. String.
    func defaultLanguage() -> String {
        var defaultLanguage: String = String()
        guard let preferredLanguage = Bundle.main.preferredLocalizations.first else {
            return DefaultLanguage
        }
        let availableLanguages: [String] = self.availableLanguages()
        if availableLanguages.contains(preferredLanguage) {
            defaultLanguage = preferredLanguage
        } else {
            defaultLanguage = DefaultLanguage
        }
        return defaultLanguage
    }
    
    /// Resets the current language to the default
    func resetCurrentLanguageToDefault() {
        setCurrentLanguage(self.defaultLanguage())
    }
    
    /// Get the current language's display name for a language.
    /// - parameter language: Desired language.
    /// - returns: The localized string.
    func displayName(language: String) -> String {
        let locale: NSLocale = NSLocale(localeIdentifier: currentLanguage())
        if let displayName = locale.displayName(forKey: NSLocale.Key.identifier, value: language) {
            return displayName
        }
        return String()
    }
}
