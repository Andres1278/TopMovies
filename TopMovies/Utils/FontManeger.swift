//
//  FontManeger.swift
//  TopMovies
//
//  Created by Pedro Andres Villamil on 7/05/24.
//

import UIKit
import os.log

protocol CustomFontProtocol {
    func fontWithStyle(_ style: CustomFontStyle, family: String) -> UIFont
}

// MARK: - CustomFontProtocol -
extension CustomFontProtocol {
    
    func fontWithStyle(_ style: CustomFontStyle, family: String) -> UIFont {
        let fontName: String = "\(family)-\(style.name)"
        guard let font = UIFont(name: fontName, size: style.size) else {
            os_log("[CustomFontProtocol] Failure instantiate custom font:", log: OSLog.view, type: .error)
            return UIFont.systemFont(ofSize: 15)
        }
        return font
    }
}

public enum CustomFont {
    
    private enum Family: String {
        case inter = "Inter"
    }
    
    public class Inter: CustomFontProtocol {
        
        // MARK: - Public Properties -
        public var font: UIFont { fontWithStyle(style, family: family) }
        
        // MARK: - Private Properties -
        private var style: CustomFontStyle
        private var family: String
        
        
        
        // MARK: - Lifecycle -
        init(style: CustomFontStyle) {
            self.style = style
            self.family = CustomFont.Family.inter.rawValue
        }
    }
}

enum CustomFontStyle {
    
    case black(CustomSizes.FontSize)
    case bold(CustomSizes.FontSize)
    case extraBold(CustomSizes.FontSize)
    case extraLight(CustomSizes.FontSize)
    case light(CustomSizes.FontSize)
    case medium(CustomSizes.FontSize)
    case regular(CustomSizes.FontSize)
    case semiBold(CustomSizes.FontSize)
    case thin(CustomSizes.FontSize)
    
    var name: String {
        switch self {
        case .black:
            return "Black"
        case .bold:
            return "Bold"
        case .extraBold:
            return "ExtraBold"
        case .extraLight:
            return "ExtraLight"
        case .light:
            return "Light"
        case .medium:
            return "Medium"
        case .regular:
            return "Regular"
        case .semiBold:
            return "SemiBold"
        case .thin:
            return "Thin"
        }
    }
    
    var size: CGFloat {
        switch self {
        case .black(let size),
                .bold(let size),
                .extraBold(let size),
                .extraLight(let size),
                .light(let size),
                .medium(let size),
                .regular(let size),
                .semiBold(let size),
                .thin(let size):
            return size.rawValue
        }
    }
}
