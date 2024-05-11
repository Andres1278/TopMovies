//
//  UIView+Utils.swift
//  TopMovies
//
//  Created by Pedro Andres Villamil on 9/05/24.
//

import UIKit

extension UIView {
    
    func round( _ radius: CGFloat = .cardCornerRadius) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func addBorder(color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}
