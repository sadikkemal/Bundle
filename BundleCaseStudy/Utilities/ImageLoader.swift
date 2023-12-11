//
//  ImageLoader.swift
//  BundleCaseStudy
//
//  Created by Sadık Kemal Sarı on 11.12.2023.
//

import Combine
import Foundation
import UIKit

// MARK: - ImageLoading
protocol ImageLoading {

    func getThumbnailImage(for path: String) async -> UIImage?
}

// MARK: - ImageLoader
final class ImageLoader: ImageLoading {

    // MARK: Internal
    static let shared = ImageLoader()

    // MARK: Private
    private let cache = NSCache<NSString, UIImage>()

    // MARK: Lifecycle
    private init() {}
}

// MARK: - Helper
private extension ImageLoader {

    func getImage(for url: URL) async -> UIImage? {
        if let cachedImage = cache.object(forKey: url.absoluteString as NSString) {
            return cachedImage
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: url.absoluteString as NSString)
            return image
        } catch {
            return nil
        }
    }
}

// MARK: - API
extension ImageLoader {

    func getThumbnailImage(for path: String) async -> UIImage? {
        let url = URL(string: path)!
        return await getImage(for: url)
    }
}
