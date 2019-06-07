//
//  UITextView.swift
//  ArmyOfOnes
//
//  Created by David Figueroa on 6/7/19.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import UIKit

extension UITextField {
    public func addBorderToTextField() {
        let textField = self
        let border = CALayer()
        border.backgroundColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }
}
