//
//  PackagesViewControllerModel.swift
//  BundleCaseStudy
//
//  Created by Sadık Kemal Sarı on 11.12.2023.
//

import Combine
import CoreData
import Foundation

// MARK: - PackagesViewControllerModel
final class PackagesViewControllerModel {

    // MARK: Types
    typealias Coordinator = PackagesCoordinator

    // MARK: Internal
    @Published private(set) var customViewModel: PackagesViewModel
    @Published private(set) var taskState: TaskState<Error>?

    // MARK: Private
    private var cancellables: Set<AnyCancellable> = Set()
    private var coordinator: Coordinator
    private var networkService: NetworkServiceProtocol
    private let imageLoader: ImageLoading

    private var packages: Packages? {
        didSet {
            customViewModel = PackagesViewModel(packages: packages, imageLoader: imageLoader)
        }
    }

    // MARK: Lifecycle
    init(
        coordinator: Coordinator,
        networkService: NetworkServiceProtocol,
        imageLoader: ImageLoading
    ){
        self.coordinator = coordinator
        self.networkService = networkService
        self.imageLoader = imageLoader
        customViewModel = PackagesViewModel(packages: packages, imageLoader: imageLoader)
        loadBindings()
    }
}

// MARK: - Bindings
private extension PackagesViewControllerModel {

    func loadBindings() {
    }
}

// MARK: - Life Cycle API
extension PackagesViewControllerModel {

    func viewDidLoad() {
        taskState = .loading
        Task {
            do {
                packages = try await networkService.fetchPackages()
                taskState = .success
            } catch {
                taskState = .failure(error: error)
            }
        }
    }
}

// MARK: - Actions API
extension PackagesViewControllerModel {

    func didTapCell(at indexPath: IndexPath) {
        let packageData = packages!.data![indexPath.item]
        coordinator.routeToPackageScreen(packageData: packageData)
    }
}
