//
//  MovieDetailModule.swift
//  TopMovies
//
//  Created by Pedro Andres Villamil on 10/05/24.
//

import Foundation

struct MovieDetailViewModel {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let raiting: String
    
    static func getMovieDetailViewModel(from data: Movie) -> Self {
        .init(
            id: data.id,
            title: data.title,
            overview: data.overview,
            releaseDate: data.releaseDate,
            raiting: String(format: "%.1f", data.voteAverage)
        )
    }
}

final class MovieDetailModule {
    
    static func createMovieDetailModule(with model: MovieDetailViewModel) -> MovieDetailViewController {
        let view = MovieDetailViewController()
        let router = MovieDetailRouter(viewController: view)
        let interactor = MovieDetailInteractor()
        let presenter: MovieDetailPresenterProtocol & MovieDetailInteractorOutputProtocol = MovieDetailPresenter(view: view, router: router, interactor: interactor, model: model)
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
}
