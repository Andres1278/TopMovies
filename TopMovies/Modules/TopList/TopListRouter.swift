//
//  TopListRouter.swift
//  TopMovies
//
//  Created by Pedro Andres Villamil on 6/05/24.
//

import Foundation

final class TopListRouter: BaseRouter<TopListViewController>, TopListRouterProtocol {
    
    func showMovieDetail(with model: MovieDetailViewModel) {
        let vc = MovieDetailModule.createMovieDetailModule(with: model)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
