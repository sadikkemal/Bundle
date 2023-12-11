//
//  UIAlertController+Additions.swift
//  BundleCaseStudy
//
//  Created by Sadık Kemal Sarı on 11.12.2023.
//

import Foundation
import UIKit

extension UIAlertController {

    static func presentError(_ error: Error, in viewController: UIViewController) {
        let alertController = Self(
            title: "An error occured!",
            message: error.localizedDescription,
            preferredStyle: .alert)

        let cancelAction = UIAlertAction(
            title: "OK",
            style: .cancel)
        alertController.addAction(cancelAction)

        viewController.present(alertController, animated: true)
    }
}
