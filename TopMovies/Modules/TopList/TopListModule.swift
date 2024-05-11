//
//  TopListModule.swift
//  TopMovies
//
//  Created by Pedro Andres Villamil on 6/05/24.
//

import Foundation

final class TopListModule {
    
    static func createTopListMopdule() -> TopListViewController {
        let view = TopListViewController()
        let presenter: TopListPresenterProtocol & TopListInteractorOutputProtocol = TopListPresenter()
        let router = TopListRouter(viewController: view)
        let interactor = TopListInteractor()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
}
