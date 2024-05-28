// RecomendationCollectionViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка коллекции с рекомендациями
final class RecomendationCollectionViewCell: UICollectionViewCell {
    // MARK: - Constants

    private enum Constants {
        static let imageRatio = 73.0 / 46.0
    }

    static let reuseId = String(describing: RecomendationCollectionViewCell.self)

    // MARK: - Visual Components

    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = .verdana(ofSize: 16)
        label.textColor = .white
        return label
    }()

    // MARK: - Private Properties

    private let networkService = NetworkService()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setViews()
        setConstraint()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViews()
        setConstraint()
    }

    // MARK: - Public Methods

    func setupCell(similarMovie: SimilarMovie?) {
        guard let similarMovie else { return }
        nameLabel.text = similarMovie.name
        networkService.loadImage(by: similarMovie.poster.url ?? "") { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(image):
                    self.movieImageView.image = image
                case let .failure(error):
                    print(error)
                }
            }
        }
    }

    // MARK: - Private Methods

    private func setViews() {
        backgroundColor = .clear
        contentView.addSubview(movieImageView)
        contentView.addSubview(nameLabel)
    }

    private func setConstraint() {
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: topAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: 220),
            movieImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11),
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 11),

            nameLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 24),
            nameLabel.widthAnchor.constraint(equalToConstant: 120),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
}
