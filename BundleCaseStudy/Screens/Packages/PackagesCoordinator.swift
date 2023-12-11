//
//  PackagesCoordinator.swift
//  BundleCaseStudy
//
//  Created by Sadık Kemal Sarı on 11.12.2023.
//

import UIKit

// MARK: - PackagesCoordinator
final class PackagesCoordinator {

    // MARK: Types
    typealias ViewController = PackagesViewController

    // MARK: Internal
    weak var viewController: ViewController!
}

// MARK: - Lifecycle API
extension PackagesCoordinator {

    func prepareScreen() -> ViewController {
        let networkService = NetworkService()
        let imageLoader = ImageLoader.shared
        let viewModel = ViewController.ViewModel(
            coordinator: self,
            networkService: networkService,
            imageLoader: imageLoader)
        let viewController = ViewController(viewModel: viewModel)
        self.viewController = viewController
        return viewController
    }
}

// MARK: - Routing API
extension PackagesCoordinator {

    func routeToPackageScreen(packageData: Packages.Datum) {
        let coordinator = PackageCoordinator()
        let viewController = coordinator.prepareScreen(packageData: packageData)
        self.viewController.navigationController?.pushViewController(viewController, animated: true)
    }
}
