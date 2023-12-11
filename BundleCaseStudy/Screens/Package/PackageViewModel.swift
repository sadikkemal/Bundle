//
//  PackageViewModel.swift
//  BundleCaseStudy
//
//  Created by Sadık Kemal Sarı on 11.12.2023.
//

import UIKit

// MARK: - PackageViewModel
struct PackageViewModel {

    // MARK: Types
    typealias SectionIdentifier = Int
    typealias Snapshot = NSDiffableDataSourceSnapshot<SectionIdentifier, ItemIdentifier>
    typealias SectionSnapshot = NSDiffableDataSourceSectionSnapshot<ItemIdentifier>

    // MARK: Internal
    let collectionViewPairs: [Pair]

    // MARK: Lifecycle
    init(package: Package?) {
        var pairs = [Pair]()

        if let package {
            let items = package.map { ItemIdentifier(packageSource: $0) }
            let pair = Pair(section: 0, items: items)
            pairs.append(pair)
        }

        collectionViewPairs = pairs
    }
}

// MARK: - API
extension PackageViewModel {

    func snapshot() -> Snapshot {
        var snapshot = Snapshot()
        let sections = collectionViewPairs.map { pair in pair.section }
        snapshot.appendSections(sections)
        for collectionViewPair in collectionViewPairs {
            snapshot.appendItems(collectionViewPair.items, toSection: collectionViewPair.section)
        }
        return snapshot
    }
}

// MARK: - PackageViewModel.Pair
extension PackageViewModel {

    struct Pair: Hashable {

        let section: SectionIdentifier
        let items: [ItemIdentifier]
    }
}

// MARK: - PackageViewModel.ItemIdentifier
extension PackageViewModel {

    enum ItemIdentifier: Hashable {

        case cell(PackageSourceCellContentConfiguration)

        // MARK: Internal
        var configuration: UIContentConfiguration {
            switch self {
            case .cell(let configuration): return configuration
            }
        }

        // MARK: Lifecycle
        init(packageSource: PackageSource) {
            let configuration = PackageSourceCellContentConfiguration(
                id: packageSource.id, 
                name: packageSource.name,
                isMarked: packageSource.isAdded ?? false)
            self = .cell(configuration)
        }
    }
}
