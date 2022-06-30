//
//  UIViewController.swift
//  Weather
//
//  Created by Владимир on 28.06.2022.
//

import UIKit

extension UIViewController {
    
    public enum Mode {
        case loading
        case success(Any?)
        case failure(Any?)
        case none
    }

    public func alert(title: String, message: String, actionTitle: String, handler: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: actionTitle, style: .default) { _ in
            handler?()
        }
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
    }
}
