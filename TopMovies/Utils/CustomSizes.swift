//
//  CustomSizes.swift
//  TopMovies
//
//  Created by Pedro Andres Villamil on 7/05/24.
//

import UIKit

enum CustomSizes {
    
    enum Padding: CGFloat {
        case xSmall
        case small
        case medium
        case normal
        case large
        case xLarge
        
        var size: CGFloat {
            switch self {
            case .xSmall:
                return 4
            case .small:
                return 8
            case .medium:
                return 16
            case .normal:
                return 22
            case .large:
                return 32
            case .xLarge:
                return 56
            }
        }
    }
    
    enum FontSize: CGFloat {
        case xSmall = 12
        case small = 14
        case medium = 16
        case normal = 18
        case large = 24
        case xLarge = 32
    }
}
