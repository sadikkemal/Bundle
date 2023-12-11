//
//  PackageCellContentConfiguration.swift
//  BundleCaseStudy
//
//  Created by Sadık Kemal Sarı on 11.12.2023.
//

import Foundation
import UIKit

// MARK: - PackageCellContentConfiguration
struct PackageCellContentConfiguration: Hashable {

    let id: Int
    let thumbnailFetcher: (() async -> UIImage?)?
    let description: String?
    let isMarked: Bool
    let textColorHexCode: String?
}

// MARK: - Hashable
extension PackageCellContentConfiguration {

    static func == (lhs: PackageCellContentConfiguration, rhs: PackageCellContentConfiguration) -> Bool {
        lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - UIContentConfiguration
extension PackageCellContentConfiguration: UIContentConfiguration {

    func makeContentView() -> UIView & UIContentView {
        PackageCellContentView(configuration: self)
    }

    func updated(for _: UIConfigurationState) -> Self {
        self
    }
}
