//
//  UIColor + Extension.swift
//  VideoGamesApp
//
//  Created by Ceren Uludoğan on 21.05.2024.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b, a: CGFloat
        switch hex.count {
        case 3:
            r = CGFloat((int >> 8) & 0xF) / 15
            g = CGFloat((int >> 4) & 0xF) / 15
            b = CGFloat(int & 0xF) / 15
            a = 1
        case 6:
            r = CGFloat((int >> 16) & 0xFF) / 255
            g = CGFloat((int >> 8) & 0xFF) / 255
            b = CGFloat(int & 0xFF) / 255
            a = 1
        case 8:
            r = CGFloat((int >> 24) & 0xFF) / 255
            g = CGFloat((int >> 16) & 0xFF) / 255
            b = CGFloat((int >> 8) & 0xFF) / 255
            a = CGFloat(int & 0xFF) / 255
        default:
            r = 0
            g = 0
            b = 0
            a = 1
        }
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
