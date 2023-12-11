//
//  NetworkService.swift
//  BundleCaseStudy
//
//  Created by Sadık Kemal Sarı on 11.12.2023.
//

import Foundation

// MARK: - NetworkService
final class NetworkService: NetworkServiceProtocol {

    private let baseURL = "https://bundle-api-contentstore-production.bundlenews.co/contentstore"
    let session = URLSession.shared

    func fetchPackages() async throws -> Packages {
        let url = URL(string: "\(baseURL)/packages")!
        let data: Packages = try await fetch(url: url)
        dump(data)
        return data
    }

    func fetchPackage(with packageId: Int) async throws -> Package {
        let url = URL(string: "\(baseURL)/package/\(packageId)/")!
        let data: Package = try await fetch(url: url)
        dump(data)
        return data
    }
}

// MARK: - Helpers
private extension NetworkService {

    func fetch<T: Codable>(url: URL) async throws -> T {
        let request = request(with: url)
        let (data, _) = try await session.data(for: request)
        let response = try JSONDecoder().decode(T.self, from: data)
        return response
    }

    func request(with url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("TR", forHTTPHeaderField: "language")
        request.setValue("TR", forHTTPHeaderField: "country")
        request.setValue("9aa43dab-d2ca-4dc1-b374-afb462b3b8e5", forHTTPHeaderField: "DeviceToken")
        request.setValue("IOS", forHTTPHeaderField: "Platform")
        return request
    }
}
