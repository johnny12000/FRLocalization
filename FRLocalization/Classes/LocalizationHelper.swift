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

let LocalizationChanged = "LocalizationChanged"

/// Manager for localization features of the app.
public class LocalizationHelper: NSObject {

    let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }

    public static var defaultHelper: LocalizationHelper = LocalizationHelper()

    /// Default language
    /// - returns: The app's default language. String.
    public func defaultLanguage() -> String {
        var defaultLanguage: String = String()
        guard let preferredLanguage = Bundle.main.preferredLocalizations.first else {
            return DefaultLanguage
        }
        let availableLanguages: [String] = self.availableLanguages
        if availableLanguages.contains(preferredLanguage) {
            defaultLanguage = preferredLanguage
        } else {
            defaultLanguage = DefaultLanguage
        }
        return defaultLanguage
    }

    /// Resets the current language to the default
    public func resetCurrentLanguageToDefault() {
        currentLanguage = defaultLanguage()
    }

    /// Get the current language's display name for a language.
    /// - parameter language: Desired language.
    /// - returns: The localized string.
    public func displayName(language: String) -> String {
        let locale: NSLocale = NSLocale(localeIdentifier: currentLanguage)
        if let displayName = locale.displayName(forKey: NSLocale.Key.identifier, value: language) {
            return displayName
        }
        return String()
    }

    public var currentLanguageWithoutLocale: String {
        let index = currentLanguage.index(currentLanguage.startIndex, offsetBy: 2)
        return currentLanguage.substring(to: index)
    }

    public var appleLanguages: [String] {
        return userDefaults.object(forKey: AppleLanguageKey) as? [String] ?? []
    }

    public var availableLanguages: [String] {
        var availableLanguages = Bundle.main.localizations
        if let indexOfBase = availableLanguages.index(of: "Base") {
            availableLanguages.remove(at: indexOfBase)
        }
        return availableLanguages
    }

    public var currentLanguage: String {
        get {
            for language in appleLanguages {
                if availableLanguages.contains(language) {
                    return language
                }
            }

            return defaultLanguage()
        }
        set {
            if newValue != currentLanguage && availableLanguages.contains(newValue) {
                var appleLanguagesArray = appleLanguages
                if let index = appleLanguagesArray.index(of: newValue) {
                    appleLanguagesArray.remove(at: index)
                }
                appleLanguagesArray.insert(newValue, at: 0)
                userDefaults.set(appleLanguagesArray, forKey: AppleLanguageKey)
                userDefaults.synchronize()
                NotificationCenter.default.post(name: NSNotification.Name(LocalizationChanged), object: nil)
            }
        }
    }
}
