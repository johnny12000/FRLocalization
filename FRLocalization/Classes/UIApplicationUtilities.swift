//
//  UIApplicationUtilities.swift
//  FRLocalization
//
//  Created by Nikola Ristic on 8/3/17.
//  Copyright © 2017 nr. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {

    class var isRTL: Bool {
        return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
    }

    var cstm_userInterfaceLayoutDirection: UIUserInterfaceLayoutDirection {
        get {
            var direction = UIUserInterfaceLayoutDirection.leftToRight
            //            if L102Language.currentAppleLanguage() == "ar" {
            //                direction = .rightToLeft
            //            }
            return direction
        }
    }
}
