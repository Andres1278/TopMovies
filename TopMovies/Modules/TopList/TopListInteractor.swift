//
//  TopListInteractor.swift
//  TopMovies
//
//  Created by Pedro Andres Villamil on 6/05/24.
//

import Foundation

final class TopListInteractor {
    
    private struct Constants {
        static let pageParameter: String = "page"
    }
    
    // MARK: - Public Properties -
    weak var presenter: TopListInteractorOutputProtocol?
    
}

// MARK: - TopListInteractorProtocol -
extension TopListInteractor: TopListInteractorProtocol {

    func getTopMoviesData(with page: Int)  {
        let queryParams: HTTPQueryParams = [Constants.pageParameter: "\(page)"]
        ServiceManger.request(
            to: API.url(for: .topRated),
            headers: API.defaultHeaders,
            queryParams: queryParams
        ) { [weak self] (response: ServiceManger.CompletionResult<TopMoviesList>) in
            guard let self else { return }
            switch response {
            case .success(let result):
                self.presenter?.getTopMoviesSuccess(with: result)
            case .failure:
                self.presenter?.getTopMoviesFailure()
            }
        }
    }
}
