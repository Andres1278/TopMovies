//
//  NetworkingManager.swift
//  TopMovies
//
//  Created by Pedro Andres Villamil on 4/05/24.
//

import Foundation
import os.log

enum NetworkError: Error {
    case badURL
    case noJSONData
    case JSONDecoder
    case unauthorized
    case unknown
    case invalidService
}

struct ServiceManger {
    
    typealias Completion<T> = (CompletionResult<T>) -> (Void)
    typealias CompletionResult<T> = Swift.Result<T, Error>
    
    public static func request<T: Codable> (
        to endpoint: String,
        method: HTTPMethod = .get,
        headers: HTTPHeaders = [:],
        queryParams: HTTPQueryParams = [:],
        keypath: String? = nil,
        completionHandler: Completion<T>?
    ) {
        
        guard let url = URL(string: endpoint) else {
            completionHandler?(.failure(NetworkError.badURL))
            return
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!

        if !queryParams.isEmpty {
            components.queryItems = queryParams.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        }

        guard let finalURL = components.url else {
            completionHandler?(.failure(NetworkError.badURL))
            return
        }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.timeoutInterval = 10
        headers.forEach { header in
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let errorCode = (error as? NSError)?.code,
               let error = errorMap(for: errorCode) {
                os_log("[ServiceManager] Servide Failure:", log: OSLog.network, type: .error)
                completionHandler?(.failure(error))
                return
            }
            
            guard let data = data else {
                completionHandler?(.failure(NetworkError.noJSONData))
                return
            }
            
            do {
                let entries = try JSONDecoder().decode(T.self, from: data as Data)
//                MARK: Delay implemented just for testing spinners
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    completionHandler?(.success(entries))
                }
                
            } catch  {
                os_log("[ServiceManager] Decoding error:", log: OSLog.network, type: .error, error as CVarArg)
                completionHandler?(.failure(NetworkError.JSONDecoder))
            }
        }
        task.resume()
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
