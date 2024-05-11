//
//  TopListPresenter.swift
//  TopMovies
//
//  Created by Pedro Andres Villamil on 6/05/24.
//

import UIKit

final class TopListPresenter {
    
    private struct Constants {
        static let initialPage: Int = 1
        static let one: Int = 1
    }
    
    // MARK: - Public Properties -
    var view: TopListViewProtocol?
    var router: TopListRouterProtocol?
    var interactor: TopListInteractorProtocol?
    var moviesResponse: TopMoviesList?
    var moviesList: [Movie] = []
    var totalMovies: Int = .zero
    
    // MARK: - Private Properties -
    
    private var isFetchInProgress: Bool = false
    private var page: Int = Constants.one
    private var totalPages: Int = .zero
    
    // MARK: - Lifecycle -
    
    
    // MARK: - Private Methods -
    
    private func resetValuesForRequest() {
        page = Constants.initialPage
        totalMovies = .zero
        moviesList = []
    }
    
    private func getMoviesData(with page: Int) {
        interactor?.getTopMoviesData(with: page)
    }
    
    private func updateView() {
        view?.updateMoviesList()
        isFetchInProgress = false
        view?.shouldShowActivityIndicator(false)
    }
}


// MARK: - TopListPresenterProtocol -
extension TopListPresenter: TopListPresenterProtocol {
    
    func viewDidLoad() {
        interactor?.getTopMoviesData(with: page)
        isFetchInProgress = true
    }
    
    func showMovieDetail(with index: IndexPath) {
        guard let movie =  moviesList.safeContains(index.row) else { return }
        let model = MovieDetailViewModel.getMovieDetailViewModel(from: movie)
        router?.showMovieDetail(with: model)
    }
    
    func getMovieCellViewModel(at index: IndexPath) -> MovieLisCellViewModel? {
        guard let movie =  moviesList.safeContains(index.row) else { return nil }
        return MovieLisCellViewModel.getMovieListCellViewModel(from: movie)
    }
    
    func isEndOfTableView(_ scrollView: UIScrollView) -> Bool {
        return scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)
    }
    
    func getMoviesList() {
        if !isFetchInProgress,
           totalMovies >= .zero,
           moviesList.count < totalMovies || moviesList.isEmpty {
            view?.shouldShowActivityIndicator(true)
            isFetchInProgress = true
            getMoviesData(with: page)
        }
    }
    
    func pullRefreshData() {
        resetValuesForRequest()
        view?.updateMoviesList()
        isFetchInProgress = true
        getMoviesData(with: page)
    }
}

// MARK: - TopListInteractorOutputProtocol -
extension TopListPresenter: TopListInteractorOutputProtocol {
    
    func getTopMoviesSuccess(with response: TopMoviesList) {
        moviesList.isEmpty ? (moviesList = response.results) : (moviesList += response.results)
        totalMovies = response.totalResults
        totalPages = response.totalPages
        moviesResponse = response
        updateView()
        page += Constants.one
    }
    
    func getTopMoviesFailure() {
        updateView()
    }
}
