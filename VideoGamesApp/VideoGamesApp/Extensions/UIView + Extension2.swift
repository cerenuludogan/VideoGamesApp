//
//  UIView + Extension2.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 25.05.2024.
//

import Foundation
import UIKit
extension UIView {
    @IBInspectable var upperCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            let maskPath = UIBezierPath(roundedRect: bounds,
                                        byRoundingCorners: [.topLeft, .topRight],
                                        cornerRadii: CGSize(width: newValue, height: newValue))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = bounds
            maskLayer.path = maskPath.cgPath
            layer.mask = maskLayer
        }
    }
}
