//
//  TopListProtocols.swift
//  TopMovies
//
//  Created by Pedro Andres Villamil on 6/05/24.
//

import UIKit

protocol TopListPresenterProtocol: AnyObject {
    var view: TopListViewProtocol? { get set }
    var router: TopListRouterProtocol? { get set }
    var interactor: TopListInteractorProtocol? { get set }
    var moviesList: [Movie] { get set }
    
    func viewDidLoad()
    func showMovieDetail(with index: IndexPath)
    func getMovieCellViewModel(at index: IndexPath) -> MovieLisCellViewModel?
    func isEndOfTableView(_ scrollView: UIScrollView) -> Bool
    func getMoviesList()
    func pullRefreshData()
}

protocol TopListInteractorProtocol: AnyObject {
    var presenter: TopListInteractorOutputProtocol? { get set }
    
    func getTopMoviesData(with page: Int)
}

protocol TopListInteractorOutputProtocol: AnyObject {
    func getTopMoviesSuccess(with response: TopMoviesList)
    func getTopMoviesFailure()
}

protocol TopListRouterProtocol: AnyObject {
    func showMovieDetail(with model: MovieDetailViewModel)
}

protocol TopListViewProtocol: AnyObject {
    var presenter: TopListPresenterProtocol? { get set }
    func updateMoviesList()
    func shouldShowActivityIndicator(_ show: Bool)
}
