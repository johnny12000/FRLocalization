//
//  UILabelUtilities.swift
//  FRLocalization
//
//  Created by Nikola Ristic on 8/3/17.
//  Copyright © 2017 nr. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {

    @objc public func localizedLayoutSubview() {
        self.localizedLayoutSubview()
        if self.isKind(of: NSClassFromString("UITextFieldLabel")!) {
            return // handle special case with uitextfields
        }
        if self.tag <= 0 {
            if UIApplication.isRTL {
                if self.textAlignment == .right {
                    return
                }
            } else {
                if self.textAlignment == .left {
                    return
                }
            }
        }
        if self.tag <= 0 {
            if UIApplication.isRTL {
                self.textAlignment = .right
            } else {
                self.textAlignment = .left
            }
        }
    }
}
