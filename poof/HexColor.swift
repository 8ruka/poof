//
//  HexColor.swift
//  
//
//  Created by Hexagons on 2019-10-27.
//

import UIKit

extension UIColor {
    
    static func hex(_ hex: String, alpha: CGFloat = 1) -> UIColor {
        var hex = hex
        if hex[0..<1] == "#" {
            if hex.count == 4 {
                hex = hex[1..<4]
            } else {
                hex = hex[1..<7]
            }
        }
        if hex.count == 3 {
            let r = hex[0..<1]
            let g = hex[1..<2]
            let b = hex[2..<3]
            hex = r + r + g + g + b + b
        }
        var hexInt: UInt32 = 0
        let scanner: Scanner = Scanner(string: hex)
        scanner.scanHexInt32(&hexInt)
        return UIColor(red: CGFloat((hexInt & 0xff0000) >> 16) / 255.0,
                       green: CGFloat((hexInt & 0xff00) >> 8) / 255.0,
                       blue: CGFloat((hexInt & 0xff) >> 0) / 255.0,
                       alpha: alpha)
    }
    
}

extension String {
    
    public subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    public subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }

}
