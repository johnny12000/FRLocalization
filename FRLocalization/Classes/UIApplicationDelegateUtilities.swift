//
//  Localizer.swift
//  FRLocalization
//
//  Created by Nikola Ristic on 8/3/17.
//  Copyright © 2017 nr. All rights reserved.
//

import Foundation
import UIKit

extension UIApplicationDelegate {

    /// Overrides the selectors required for change of localization in run-time.
    public func overrideLocalizationSelectors() {

        swizzleMethod(cls: Bundle.self,
                      originalSelector: #selector(Bundle.localizedString(forKey:value:table:)),
                      overrideSelector: #selector(Bundle.specialLocalizedString(forKey:value:table:)))
        swizzleMethod(cls: UIApplication.self,
                      originalSelector: #selector(getter: UIApplication.userInterfaceLayoutDirection),
                      overrideSelector: #selector(getter: UIApplication.cstm_userInterfaceLayoutDirection))
        swizzleMethod(cls: UITextField.self,
                      originalSelector: #selector(UITextField.layoutSubviews),
                      overrideSelector: #selector(UITextField.localizedLayoutSubview))
        swizzleMethod(cls: UILabel.self,
                      originalSelector: #selector(UILabel.layoutSubviews),
                      overrideSelector: #selector(UILabel.localizedLayoutSubview))
    }
}

/// Exchange the implementation of two methods of the same Class
/// - parameter cls:              Class
/// - parameter originalSelector: Selector to replace
/// - parameter overrideSelector: Replace selector
func swizzleMethod(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    let origMethod: Method = class_getInstanceMethod(cls, originalSelector)
    let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector)
    if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod))
    } else {
        method_exchangeImplementations(origMethod, overrideMethod)
    }
}
