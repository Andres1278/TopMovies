//
//  MovieDetailProtocolos.swift
//  TopMovies
//
//  Created by Pedro Andres Villamil on 10/05/24.
//

import UIKit

protocol MovieDetailPresenterProtocol: AnyObject {
    var view: MovieDetailViewProtocol? { get set }
    var router: MovieDetailRouterProtocol? { get set }
    var interactor: MovieDetailInteractorProtocol? { get set }
    var model: MovieDetailViewModel { get set }
    var movieDetail: MovieDetail? { get set }
    var hasValidHomePageURL: Bool { get }
    
    func viewDidLoad()
    func openHomePage()
    func openRaitingAlert()
}

protocol MovieDetailInteractorProtocol: AnyObject {
    var presenter: MovieDetailInteractorOutputProtocol? { get set }
    func getMovieDetaila(with id: String)
}

protocol MovieDetailInteractorOutputProtocol: AnyObject {
    func getMoviesDetailSuccess(with response: MovieDetail)
    func getMoviesDetailFailure()
}

protocol MovieDetailRouterProtocol: AnyObject {
    func openHomePage(with url: URL)
    func dismiss()
    func showRaitingAlert(
        title:String?,
        subtitle:String?,
        actionTitle: String?,
        cancelTitle: String?,
        inputPlaceholder: String?,
        inputKeyboardType:UIKeyboardType,
        cancelHandler: ((UIAlertAction) -> Void)?,
        actionHandler: ((_ text: String?) -> Void)?
    )
}

protocol MovieDetailViewProtocol: AnyObject {
    var presenter: MovieDetailPresenterProtocol? { get set }
    func configureDetails(with movie: MovieDetail)
    func updateRaiting(with raiting: String)
}
