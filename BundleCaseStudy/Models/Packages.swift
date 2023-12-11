//
//  Packages.swift
//  BundleCaseStudy
//
//  Created by Sadık Kemal Sarı on 11.12.2023.
//

import Foundation

// MARK: - Packages
struct Packages: Codable {

    let bundleStatusCode: Int?
    let errorMessage: String?
    let data: [Datum]?
}

// MARK: - Datum
extension Packages {

    struct Datum: Codable {

        let id: Int
        let isAdded: Bool?
        let name, description: String?
        let index: Int?
        let image: String?
        let style: Style?
        let sourceCount: Int?
    }
}

// MARK: - Style
extension Packages.Datum {

    struct Style: Codable {

        let fontColor: String?
    }
}
