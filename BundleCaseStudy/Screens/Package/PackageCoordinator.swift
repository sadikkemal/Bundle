//
//  PackageCoordinator.swift
//  BundleCaseStudy
//
//  Created by Sadık Kemal Sarı on 11.12.2023.
//

import UIKit

// MARK: - PackageCoordinator
final class PackageCoordinator {

    // MARK: Types
    typealias ViewController = PackageViewController

    // MARK: Internal
    weak var viewController: ViewController!
}

// MARK: - Lifecycle API
extension PackageCoordinator {

    func prepareScreen(packageData: Packages.Datum) -> ViewController {
        let networkService = NetworkService()
        let viewModel = ViewController.ViewModel(
            coordinator: self,
            networkService: networkService,
            packageData: packageData)
        let viewController = ViewController(viewModel: viewModel)
        self.viewController = viewController
        return viewController
    }
}
