//
//  UITableView+Utils.swift
//  TopMovies
//
//  Created by Pedro Andres Villamil on 9/05/24.
//

import UIKit

protocol Describable {
    static var name: String { get }
}

extension Describable {
    static var name: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Describable { }

extension UITableView {
    
    func reloadDataCustom() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}

