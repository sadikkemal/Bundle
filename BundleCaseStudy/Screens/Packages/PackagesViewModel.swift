//
//  PackagesViewModel.swift
//  BundleCaseStudy
//
//  Created by Sadık Kemal Sarı on 11.12.2023.
//

import UIKit

// MARK: - PackagesViewModel
struct PackagesViewModel {

    // MARK: Types
    typealias SectionIdentifier = Int
    typealias Snapshot = NSDiffableDataSourceSnapshot<SectionIdentifier, ItemIdentifier>
    typealias SectionSnapshot = NSDiffableDataSourceSectionSnapshot<ItemIdentifier>

    // MARK: Internal
    let collectionViewPairs: [Pair]

    // MARK: Lifecycle
    init(packages: Packages?, imageLoader: ImageLoading) {
        var pairs = [Pair]()
        if let data = packages?.data {
            let items = data.map { ItemIdentifier(package: $0, imageLoader: imageLoader) }
            let pair = Pair(section: 0, items: items)
            pairs.append(pair)
        }

        collectionViewPairs = pairs
    }
}

// MARK: - API
extension PackagesViewModel {

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

// MARK: - PackagesViewModel.Pair
extension PackagesViewModel {

    struct Pair: Hashable {

        let section: SectionIdentifier
        let items: [ItemIdentifier]
    }
}

// MARK: - PackagesViewModel.ItemIdentifier
extension PackagesViewModel {

    enum ItemIdentifier: Hashable {

        case cell(PackageCellContentConfiguration)

        // MARK: Internal
        var configuration: UIContentConfiguration {
            switch self {
            case .cell(let configuration): return configuration
            }
        }

        // MARK: Lifecycle
        init(package: Packages.Datum, imageLoader: ImageLoading) {
            let thumbnailFetcher: (() async -> UIImage?)?
            if let posterPath = package.image {
                thumbnailFetcher = {
                    await imageLoader.getThumbnailImage(for: posterPath)
                }
            } else {
                thumbnailFetcher = nil
            }

            let configuration = PackageCellContentConfiguration(
                id: package.id,
                thumbnailFetcher: thumbnailFetcher,
                description: package.description,
                isMarked: package.isAdded ?? false,
                textColorHexCode: package.style?.fontColor)
            self = .cell(configuration)
        }
    }
}
