//
//  PackageViewController.swift
//  BundleCaseStudy
//
//  Created by Sadık Kemal Sarı on 11.12.2023.
//

import Combine
import UIKit

// MARK: - PackageViewController
final class PackageViewController: UIViewController {

    // MARK: Types
    typealias ViewModel = PackageViewControllerModel

    // MARK: Private
    private var viewModel: ViewModel
    private var cancellables: Set<AnyCancellable> = Set()

    private var customView: PackageView {
        view as! PackageView
    }

    // MARK: Lifecycle
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = PackageView(viewModel: viewModel.customViewModel)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadNavigationItem()
        loadViewBindings()
        loadViewModelBindings()
        viewModel.viewDidLoad()
    }
}

// MARK: - Views
private extension PackageViewController {

    func loadNavigationItem() {
        navigationItem.title = "Package"
    }
}

// MARK: - Bindings
private extension PackageViewController {

    func loadViewBindings() {
    }

    func loadViewModelBindings() {
        viewModel.$customViewModel
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] updatedViewModel in
                customView.viewModel = updatedViewModel
            }
            .store(in: &cancellables)

        viewModel.$taskState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] taskState in
                guard let self else { return }
                if case .failure(let error) = taskState {
                    UIAlertController.presentError(error, in: self)
                }
            }
            .store(in: &cancellables)
    }
}
