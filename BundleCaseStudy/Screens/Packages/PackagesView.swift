//
//  PackagesView.swift
//  BundleCaseStudy
//
//  Created by Sadık Kemal Sarı on 11.12.2023.
//

import Combine
import UIKit

// MARK: - PackagesView
final class PackagesView: UIView {

    // MARK: Types
    typealias ViewModel = PackagesViewModel
    typealias CellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, ViewModel.ItemIdentifier>
    typealias System = UICollectionView.SupplementaryRegistration<UICollectionViewListCell>
    typealias CollectionViewDiffableDataSource = UICollectionViewDiffableDataSource<
        ViewModel.SectionIdentifier,
        ViewModel.ItemIdentifier
    >

    // MARK: Internal
    var viewModel: ViewModel {
        didSet { update(for: viewModel) }
    }

    private(set) var didTapCellPublisher: PassthroughSubject<IndexPath, Never> = PassthroughSubject()

    // MARK: Private
    private weak var collectionView: UICollectionView!
    private var collectionViewDiffableDataSource: CollectionViewDiffableDataSource!

    // MARK: Lifecycle
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        loadCollectionView()
        loadConstraints()
        update(for: viewModel)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Views
private extension PackagesView {

    func loadCollectionView() {
        let configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        addSubview(collectionView)

        let cellRegistration = CellRegistration { cell, _, itemIdentifier in
            cell.contentConfiguration = itemIdentifier.configuration
        }

        let collectionViewDiffableDataSource =
            CollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
                collectionView.dequeueConfiguredReusableCell(
                    using: cellRegistration,
                    for: indexPath,
                    item: itemIdentifier)
            }

        self.collectionView = collectionView
        self.collectionViewDiffableDataSource = collectionViewDiffableDataSource
    }
}

// MARK: - Constraints
private extension PackagesView {

    func loadConstraints() {
        let constraints = [
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - Helpers
private extension PackagesView {

    func update(for viewModel: ViewModel) {
        let snapshot = viewModel.snapshot()
        collectionViewDiffableDataSource.apply(snapshot, animatingDifferences: true)
    }
}

// MARK: - UICollectionViewDelegate
extension PackagesView: UICollectionViewDelegate {

    func collectionView(_: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didTapCellPublisher.send(indexPath)
    }
}
