//
//  Collection+Utils.swift
//  TopMovies
//
//  Created by Pedro Andres Villamil on 10/05/24.
//

import Foundation

extension Collection {
    func safeContains(_ index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
