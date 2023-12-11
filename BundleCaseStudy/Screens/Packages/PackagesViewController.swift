//
//  PackagesViewController.swift
//  BundleCaseStudy
//
//  Created by Sadık Kemal Sarı on 11.12.2023.
//

import Combine
import UIKit

// MARK: - PackagesViewController
final class PackagesViewController: UIViewController {

    // MARK: Types
    typealias ViewModel = PackagesViewControllerModel

    // MARK: Private
    private var viewModel: ViewModel
    private var cancellables: Set<AnyCancellable> = Set()

    private var customView: PackagesView {
        view as! PackagesView
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
        view = PackagesView(viewModel: viewModel.customViewModel)
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
private extension PackagesViewController {

    func loadNavigationItem() {
        navigationItem.title = "Packages"
    }
}

// MARK: - Bindings
private extension PackagesViewController {

    func loadViewBindings() {
        customView.didTapCellPublisher
            .sink { [unowned self] indexPath in
                viewModel.didTapCell(at: indexPath)
            }
            .store(in: &cancellables)
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
