//
//  BundleUtilities.swift
//  FRLocalization
//
//  Created by Nikola Ristic on 8/3/17.
//  Copyright © 2017 nr. All rights reserved.
//

import Foundation
import UIKit

extension Bundle {

    /// Specialized method for localization on change of localization.
    /// - parameter forKey: Key
    /// - parameter value:  Value
    /// - parameter table:  Table
    /// - returns: Localized string.
    @objc func specialLocalizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        var bundle: Bundle!
        bundle = self

        if bundle == Bundle.main {
            let currentLanguage = LocalizationHelper.defaultHelper.currentLanguage
            let currengLanguageWithoutLocale = LocalizationHelper.defaultHelper.currentLanguageWithoutLocale
            if let path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
                bundle = Bundle(path: path)
            } else if let path = Bundle.main.path(forResource: currengLanguageWithoutLocale, ofType: "lproj") {
                bundle = Bundle(path: path)
            }
        }
        return bundle.specialLocalizedString(forKey: key, value: value, table: tableName)
    }
}
