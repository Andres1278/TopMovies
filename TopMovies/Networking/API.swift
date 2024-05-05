//
//  API.swift
//  TopMovies
//
//  Created by Pedro Andres Villamil on 4/05/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

internal typealias HTTPHeaders = [String: String]

struct API {
    
    let apiKey = "4d58b851c31392bbf03cdf8fed99247c"
    private static let baseUrl = "https://api.themoviedb.org/3/movie/"
    let defaultRequestParameters = ["limit": "100"]
    static var defaultHeaders: HTTPHeaders = [
        "accept": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ZDU4Yjg1MWMzMTM5MmJiZjAzY2RmOGZlZDk5MjQ3YyIsInN1YiI6IjYwNzhkYTQ2YWI2ODQ5MDA2ZjVkZjA1MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.0pnTRarCOACvXrrVJjANMZwU3XCzldRxH09i5_I5Tc8"
    ]

    enum Endpoint {
        case topRated
        case movesList
        case moveDetail(name: String)
        
        var path: String {
            switch self {
            case .topRated:
                return  "top_rated"
            case .movesList:
                return "/move"
            case .moveDetail(let name):
                return  "/move/\(name)"
            }
        }
    }
    
    static func url(for endpoint: Endpoint) -> String {
        return baseUrl + endpoint.path
    }
}
