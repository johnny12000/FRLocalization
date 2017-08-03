//
//  UITextFieldUtilities.swift
//  FRLocalization
//
//  Created by Nikola Ristic on 8/3/17.
//  Copyright © 2017 nr. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    public func localizedLayoutSubview() {
        self.localizedLayoutSubview()
        if self.tag <= 0 {
            if UIApplication.isRTL {
                if self.textAlignment == .right { return }
                self.textAlignment = .right
            } else {
                if self.textAlignment == .left { return }
                self.textAlignment = .left
            }
        }
    }
}
