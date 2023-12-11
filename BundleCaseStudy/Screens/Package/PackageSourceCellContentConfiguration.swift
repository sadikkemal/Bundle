//
//  PackageSourceCellContentConfiguration.swift
//  BundleCaseStudy
//
//  Created by Sadık Kemal Sarı on 11.12.2023.
//

import Foundation
import UIKit

// MARK: - PackageSourceCellContentConfiguration
struct PackageSourceCellContentConfiguration: Hashable {

    let id: Int
    let name: String?
    let isMarked: Bool
}

// MARK: - UIContentConfiguration
extension PackageSourceCellContentConfiguration: UIContentConfiguration {

    func makeContentView() -> UIView & UIContentView {
        PackageSourceCellContentView(configuration: self)
    }

    func updated(for _: UIConfigurationState) -> Self {
        self
    }
}
