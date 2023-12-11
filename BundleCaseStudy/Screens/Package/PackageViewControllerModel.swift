//
//  PackageViewControllerModel.swift
//  BundleCaseStudy
//
//  Created by Sadık Kemal Sarı on 11.12.2023.
//

import Combine
import CoreData
import Foundation

// MARK: - PackageViewControllerModel
final class PackageViewControllerModel {

    // MARK: Types
    typealias Coordinator = PackageCoordinator

    // MARK: Internal
    @Published private(set) var customViewModel: PackageViewModel
    @Published private(set) var taskState: TaskState<Error>?

    // MARK: Private
    private let coordinator: Coordinator
    private let networkService: NetworkServiceProtocol
    private let packageData: Packages.Datum

    private var cancellables: Set<AnyCancellable> = Set()
    private var package: Package? {
        didSet {
            customViewModel = PackageViewModel(package: package)
        }
    }

    // MARK: Lifecycle
    init(
        coordinator: Coordinator,
        networkService: NetworkServiceProtocol,
        packageData: Packages.Datum
    ){
        self.coordinator = coordinator
        self.networkService = networkService
        self.packageData = packageData
        customViewModel = PackageViewModel(package: package)
    }
}

// MARK: - Life Cycle API
extension PackageViewControllerModel {

    func viewDidLoad() {
        taskState = .loading
        Task {
            do {
                self.package = try await networkService.fetchPackage(with: packageData.id)
                taskState = .success
            } catch {
                taskState = .failure(error: error)
            }
        }
    }
}
