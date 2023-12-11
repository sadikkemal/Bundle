//
//  PackageSourceCellContentView.swift
//  BundleCaseStudy
//
//  Created by Sadık Kemal Sarı on 11.12.2023.
//

import Combine
import UIKit

// MARK: - PackageSourceCellContentView
final class PackageSourceCellContentView: UIView, UIContentView {

    // MARK: Types
    typealias Configuration = PackageSourceCellContentConfiguration

    // MARK: Internal
    var configuration: UIContentConfiguration {
        didSet { update(for: configuration) }
    }

    override var intrinsicContentSize: CGSize {
        CGSize(width: 0, height: 44)
    }

    // MARK: Private
    private weak var nameLabel: UILabel!
    private weak var checkboxImageView: UIImageView!

    // MARK: Lifecycle
    init(configuration: Configuration) {
        self.configuration = configuration
        super.init(frame: .zero)
        loadNameLabel()
        loadCheckboxImageView()
        loadConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Views
private extension PackageSourceCellContentView {

    func loadNameLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String()
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .body)
        addSubview(label)
        nameLabel = label
    }

    func loadCheckboxImageView() {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .label
        addSubview(imageView)
        checkboxImageView = imageView
    }
}

// MARK: - Constraints
private extension PackageSourceCellContentView {

    func loadConstraints() {
        let constraints = [
            nameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),

            checkboxImageView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 16),
            checkboxImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            checkboxImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            checkboxImageView.widthAnchor.constraint(equalToConstant: 24),
            checkboxImageView.heightAnchor.constraint(equalToConstant: 24),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - Bindings
private extension PackageSourceCellContentView { }

// MARK: - Helpers
private extension PackageSourceCellContentView {

    func update(for configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        nameLabel.text = configuration.name
        if configuration.isMarked {
            checkboxImageView.image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        } else {
            checkboxImageView.image = UIImage(systemName: "star")?.withRenderingMode(.alwaysTemplate)
        }
    }
}
