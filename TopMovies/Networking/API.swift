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
internal typealias HTTPQueryParams = [String: String]

struct API {
    
    let apiKey = "4d58b851c31392bbf03cdf8fed99247c"
    private static let baseUrl = "https://api.themoviedb.org/3/"
    private static let posterBaseURL = "https://image.tmdb.org/t/p/w500"
    let defaultRequestParameters = ["limit": "100"]
    static var defaultHeaders: HTTPHeaders = [
        "accept": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0ZDU4Yjg1MWMzMTM5MmJiZjAzY2RmOGZlZDk5MjQ3YyIsInN1YiI6IjYwNzhkYTQ2YWI2ODQ5MDA2ZjVkZjA1MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.0pnTRarCOACvXrrVJjANMZwU3XCzldRxH09i5_I5Tc8"
    ]

    enum Endpoint {
        case topRated
        case movieDetail(id: String)
        case poster(path: String)
        
        var path: String {
            switch self {
            case .topRated:
                return  "movie/top_rated"
            case .movieDetail(let id):
                return  "movie/\(id)"
            case .poster(let path):
                return path
            }
        }
    }
    
    static func url(for endpoint: Endpoint) -> String {
        return baseUrl + endpoint.path
    }
    
    static func posterURL(for endPoint: Endpoint) -> String {
        return posterBaseURL + endPoint.path
    }
}
