//
//  UIColor+Utils.swift
//  TopMovies
//
//  Created by Pedro Andres Villamil on 7/05/24.
//

import UIKit

extension UIColor {
    
    private struct Constants {
        static let alpha: CGFloat = 1.0
        static let colorHex900: String = "#003A40"
        static let colorHex800: String = "#336166"
        static let colorHex700: String = "#66898C"
        static let colorHex600: String = "#809DA0"
        static let colorHex500: String = "#99B0B3"
        static let colorHex400: String = "#B3C4C6"
        static let colorHex300: String = "#CCD8D9"
        static let colorHex200: String = "#E6EBEC"
        static let colorHex100: String = "#F3F5F6"
    }
    
    convenience init(hex: String, alpha: CGFloat = Constants.alpha) {
        
        var hexValue = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexValue.hasPrefix("#") {
            hexValue.remove(at: hexValue.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexValue).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static var baseColor900: UIColor { UIColor(hex: Constants.colorHex900) }
    static var baseColor800: UIColor { UIColor(hex: Constants.colorHex800) }
    static var baseColor700: UIColor { UIColor(hex: Constants.colorHex700) }
    static var baseColor600: UIColor { UIColor(hex: Constants.colorHex600) }
    static var baseColor500: UIColor { UIColor(hex: Constants.colorHex500) }
    static var baseColor400: UIColor { UIColor(hex: Constants.colorHex400) }
    static var baseColor300: UIColor { UIColor(hex: Constants.colorHex300) }
    static var baseColor200: UIColor { UIColor(hex: Constants.colorHex200) }
    static var baseColor100: UIColor { UIColor(hex: Constants.colorHex100) }
}
