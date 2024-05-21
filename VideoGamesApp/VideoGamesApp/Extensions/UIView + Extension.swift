//
//  UIView + Extension.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 21.05.2024.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}

