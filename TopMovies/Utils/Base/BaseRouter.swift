//
//  BaseRouter.swift
//  TopMovies
//
//  Created by Pedro Andres Villamil on 10/05/24.
//

import UIKit
import OSLog


class BaseRouter<ViewController> where ViewController: UIViewController {

    private unowned var _viewController: ViewController

    private var temporaryStoredViewController: ViewController?

    init(viewController: ViewController) {
        temporaryStoredViewController = viewController
        _viewController = viewController
    }

}

extension BaseRouter {

    var viewController: ViewController {
        defer { temporaryStoredViewController = nil }
        return _viewController
    }

    var navigationController: UINavigationController? {
        return viewController.navigationController
    }

}
