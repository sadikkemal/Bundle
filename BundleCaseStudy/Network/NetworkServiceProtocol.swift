//
//  NetworkServiceProtocol.swift
//  BundleCaseStudy
//
//  Created by Sadık Kemal Sarı on 11.12.2023.
//

import Foundation

protocol NetworkServiceProtocol {

    func fetchPackages() async throws -> Packages
    func fetchPackage(with packageId: Int) async throws -> Package
}
