//
//  TopMoviesUseCase.swift
//  TopMovies
//
//  Created by Pedro Andres Villamil on 5/05/24.
//

import Foundation

enum TopMoviesResponse {
    case success(response: TopMoviesList?)
    case failure(Error?)
}

struct TopMoviesList: Codable {
    let page: Int
    let totalPages: Int
    let totalResults: Int
    let results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case results
    }
}

struct Movie: Codable {
    let backdropPath: String
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let title: String
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}
