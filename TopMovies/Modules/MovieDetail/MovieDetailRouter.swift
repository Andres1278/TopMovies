//
//  MovieDetailRouter.swift
//  TopMovies
//
//  Created by Pedro Andres Villamil on 10/05/24.
//

import UIKit

final class MovieDetailRouter: BaseRouter<MovieDetailViewController>, MovieDetailRouterProtocol {
    
    func openHomePage(with url: URL) {
        UIApplication.shared.open(url)
    }
    
    func dismiss() {
        viewController.dismiss(animated: true)
    }
    
    func showRaitingAlert(
        title:String?,
        subtitle:String?,
        actionTitle: String?,
        cancelTitle: String?,
        inputPlaceholder: String?,
        inputKeyboardType:UIKeyboardType,
        cancelHandler: ((UIAlertAction) -> Void)?,
        actionHandler: ((_ text: String?) -> Void)?
    ) {
        
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = inputPlaceholder
            textField.keyboardType = inputKeyboardType
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first else {
                actionHandler?(nil)
                return
            }
            actionHandler?(textField.text)
        }))
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelHandler))
        viewController.present(alert, animated: true, completion: nil)
    }
}
