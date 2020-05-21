//
//  UIAlertController.swift
//  VK_GeekBrains
//
//  Created by Станислав Белых on 21.05.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

extension UIAlertController {
    func pruneNegativeWidthConstraints() {
        for subView in self.view.subviews {
            for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
                subView.removeConstraint(constraint)
            }
        }
    }
}

