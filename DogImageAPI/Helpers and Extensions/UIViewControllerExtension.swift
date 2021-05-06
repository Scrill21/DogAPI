//
//  UIViewControllerExtension.swift
//  DogImageAPI
//
//  Created by anthony byrd on 5/6/21.
//

import UIKit

extension UIViewController {
    func presentErrorToUser(localizedError: LocalizedError) {
        let alertController = UIAlertController(title: "Error", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
}
