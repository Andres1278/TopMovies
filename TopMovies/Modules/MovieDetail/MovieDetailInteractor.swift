//
//  MovieDetailInteractor.swift
//  TopMovies
//
//  Created by Pedro Andres Villamil on 10/05/24.
//

import Foundation

final class MovieDetailInteractor {
    
    // MARK: - Public Properties -
    weak var presenter: MovieDetailInteractorOutputProtocol?
    
}

// MARK: - TopListInteractorProtocol -
extension MovieDetailInteractor: MovieDetailInteractorProtocol {

    func getMovieDetaila(with id: String) {
        ServiceManger.request(
            to: API.url(for: .movieDetail(id: id)),
            headers: API.defaultHeaders
        ) { [weak self] (response: ServiceManger.CompletionResult<MovieDetail>) in
            guard let self else { return }
            switch response {
            case .success(let result):
                presenter?.getMoviesDetailSuccess(with: result)
            case .failure:
                presenter?.getMoviesDetailFailure()
            }
        }
    }

    
}
