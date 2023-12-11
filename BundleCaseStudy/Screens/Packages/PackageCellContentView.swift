//
//  PackageCellContentView.swift
//  BundleCaseStudy
//
//  Created by Sadık Kemal Sarı on 11.12.2023.
//

import Combine
import UIKit

// MARK: - PackageCellContentView
final class PackageCellContentView: UIView, UIContentView {

    // MARK: Types
    typealias Configuration = PackageCellContentConfiguration

    // MARK: Internal
    var configuration: UIContentConfiguration {
        didSet { update(for: configuration) }
    }

    // MARK: Private
    private weak var thumbnailImageView: UIImageView!
    private weak var descriptionLabel: UILabel!
    private weak var checkboxImageView: UIImageView!

    private var task: Task<(), Never>?

    // MARK: Lifecycle
    init(configuration: Configuration) {
        self.configuration = configuration
        super.init(frame: .zero)
        loadThumbnailImageView()
        loadDescriptionLabel()
        loadCheckboxImageView()
        loadConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Views
private extension PackageCellContentView {

    func loadThumbnailImageView() {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        thumbnailImageView = imageView
    }

    func loadDescriptionLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String()
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        addSubview(label)
        descriptionLabel = label
    }

    func loadCheckboxImageView() {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        addSubview(imageView)
        checkboxImageView = imageView
    }
}

// MARK: - Constraints
private extension PackageCellContentView {

    func loadConstraints() {
        let constraints = [
            thumbnailImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 2),
            thumbnailImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -2),
            thumbnailImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            thumbnailImageView.widthAnchor.constraint(equalTo: thumbnailImageView.heightAnchor, multiplier: 3),

            descriptionLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: thumbnailImageView.centerXAnchor, constant: -16),
            descriptionLabel.topAnchor.constraint(equalTo: thumbnailImageView.topAnchor, constant: 16),
            descriptionLabel.bottomAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: -16),

            checkboxImageView.leadingAnchor.constraint(equalTo: thumbnailImageView.leadingAnchor, constant: 16),
            checkboxImageView.topAnchor.constraint(equalTo: thumbnailImageView.topAnchor, constant: 16),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - Bindings
private extension PackageCellContentView { }

// MARK: - Helpers
private extension PackageCellContentView {

    func update(for configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }

        if let task {
            task.cancel()
        }
        thumbnailImageView.image = nil
        task = Task {
            let image = await configuration.thumbnailFetcher?()
            DispatchQueue.main.async { [weak self] in
                self?.thumbnailImageView.image = image
            }
        }

        descriptionLabel.text = configuration.description
        descriptionLabel.textColor = UIColor(hex: configuration.textColorHexCode ?? "#000000")
        checkboxImageView.isHidden = !configuration.isMarked
        checkboxImageView.tintColor = UIColor(hex: configuration.textColorHexCode ?? "#000000")
    }
}
