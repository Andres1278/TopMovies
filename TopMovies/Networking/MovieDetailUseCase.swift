//
//  MovieDetailResponse.swift
//  TopMovies
//
//  Created by Pedro Andres Villamil on 10/05/24.
//

import Foundation

struct MovieDetail: Codable {
    let budget: Int
    let original_title: String
    let overview: String
    let popularity: Double
    let release_date: String
    let revenue: Int
    let status: String
    let tagline: String
    let vote_average: Double
    let production_countries: [Production]
    let genres: [Gender]
    let original_language: String
    let poster_path: String
    let title: String
}

struct Gender: Codable {
    let name: String
}

struct Production: Codable {
    let name: String
}
