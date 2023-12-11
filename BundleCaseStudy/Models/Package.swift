//
//  Package.swift
//  BundleCaseStudy
//
//  Created by Sadık Kemal Sarı on 11.12.2023.
//

import Foundation

// MARK: - Package
typealias Package = [PackageSource]

// MARK: - Package
struct PackageSource: Codable {

    let id: Int
    let isAdded: Bool?
    let name: String?
    let index, channelCategoryID: Int?
    let categoryLocalizationKey: String?
    let countryID: Int?
    let isVideoChannel: Bool?

    enum CodingKeys: String, CodingKey {
        case id, isAdded, name, index
        case channelCategoryID = "channelCategoryId"
        case categoryLocalizationKey
        case countryID = "countryId"
        case isVideoChannel
    }
}
