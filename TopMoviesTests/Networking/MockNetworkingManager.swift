//
//  MockNetworkingManager.swift
//  TopMoviesTests
//
//  Created by Pedro Andres Villamil on 10/05/24.
//

import Foundation

class MockNetworkingManager {
    
    static let share = MockNetworkingManager()
    
    enum NetworkError: Error {
        case badURL
        case noJSONData
        case JSONDecoder
        case unauthorized
        case unknown
        case invalidService
    }
    
    typealias Completion<T> = (CompletionResult<T>) -> (Void)
    typealias CompletionResult<T> = Swift.Result<T, Error>
    
    public func createMockeSesion<T: Codable>(from jsonFile: String, statusCode: Int, completionHandler: Completion<T>?) {
        
        if let error = MockNetworkingManager.errorMap(for: statusCode) {
            completionHandler?(.failure(error))
            return
        }
        
        if let jsonFilePath = Bundle(for: type(of: self)).path(forResource: jsonFile, ofType: "json") {
            let jsonURL = URL(fileURLWithPath: jsonFilePath)
            let data = try! Data(contentsOf: jsonURL)
            do {
                let jsonDescription = try JSONDecoder().decode(T.self, from: data)
                completionHandler?(.success(jsonDescription))
            } catch {
                completionHandler?(.failure(NetworkError.JSONDecoder))
            }
            
        }
    }
    
    static func errorMap(for code: Int?) -> Error? {
        guard let code = code else { return nil }
        switch code {
        case 200...299:
            return nil
        case 400...499:
            return NetworkError.unauthorized
        case 501:
            return NetworkError.invalidService
        default:
            return NetworkError.unknown
        }
    }
}
