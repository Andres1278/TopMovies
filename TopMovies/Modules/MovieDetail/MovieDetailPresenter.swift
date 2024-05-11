//
//  MovieDetailPresenter.swift
//  TopMovies
//
//  Created by Pedro Andres Villamil on 10/05/24.
//

import UIKit

final class MovieDetailPresenter {

    private struct Constants {
        static let actionTitle: String = "Add raiting"
        static let cancelTitle: String = "Cancel"
        static let title: String = "Raiting"
        static let subtitle: String = "Add your movie raiting between 0 to 10."
        static let placeholder: String = "Write your raiting here..."
        static let maxRaiting: Int = 10
    }
    
    // MARK: - Public Properties -
    var view: MovieDetailViewProtocol?
    var router: MovieDetailRouterProtocol?
    var interactor: MovieDetailInteractorProtocol?
    var model: MovieDetailViewModel
    var movieDetail: MovieDetail?
    var newRaiting: String?
    
    // MARK: - Lifecycle -
    
    init(view: MovieDetailViewProtocol, router: MovieDetailRouterProtocol, interactor: MovieDetailInteractorProtocol, model: MovieDetailViewModel) {
        self.view = view
        self.router = router
        self.interactor = interactor
        self.model = model
    }
    
    // MARK: - Private Methods -
    

}


// MARK: - MovieDetailPresenterProtocol -
extension MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    var hasValidHomePageURL: Bool {
        guard let stringUrl = movieDetail?.homepage,
              let _ = URL(string: stringUrl) else {
            return false
        }
        return true
    }
    
    func viewDidLoad() {
        interactor?.getMovieDetaila(with: String(model.id))
    }
    
    func openHomePage() {
        if let stringUrl = movieDetail?.homepage,
           let url = URL(string: stringUrl) {
            router?.openHomePage(with: url)
        }
    }
    
    func openRaitingAlert() {
        router?.showRaitingAlert(
            title: Constants.title,
            subtitle: Constants.subtitle,
            actionTitle: Constants.actionTitle,
            cancelTitle: Constants.cancelTitle,
            inputPlaceholder: Constants.placeholder,
            inputKeyboardType: .numberPad,
            cancelHandler: nil,
            actionHandler: { [weak self] text in
                guard let self, let text, let intRaiting = Int(text) else { return }
                if intRaiting > Constants.maxRaiting {
                    self.view?.updateRaiting(with: String(Constants.maxRaiting))
                } else {
                    self.newRaiting = text
                    self.view?.updateRaiting(with: newRaiting ?? "")
                }
            }
        )
    }
}

// MARK: - MovieDetailInteractorOutputProtocol -
extension MovieDetailPresenter: MovieDetailInteractorOutputProtocol {
    
    func getMoviesDetailSuccess(with response: MovieDetail) {
        movieDetail = response
        guard let movieDetail else { return }
        view?.configureDetails(with: movieDetail)
    }
    
    func getMoviesDetailFailure() {
        router?.dismiss()
    }
}

