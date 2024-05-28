// HeaderTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с картинкой и названием фильма
final class HeaderTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let buttonTitle = "Смотреть"
        static let star = "⭐"
    }

    private let networkService = NetworkService()

    static let reuseId = String(describing: HeaderTableViewCell.self)

    // MARK: - Visual Components

    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = .verdana(ofSize: 16)
        label.textColor = .white
        return label
    }()

    private lazy var watchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .appButton
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .verdana(ofSize: 14)
        button.setTitle(Constants.buttonTitle, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()

    // MARK: - Public Properties

    func setupCell(movieDetail: MovieDetail?) {
        networkService.loadImage(by: movieDetail?.posterURL ?? "") { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(image):
                    self.movieImageView.image = image
                case let .failure(error):
                    print(error)
                }
            }
        }
        let rating = String(format: "%0.1f", movieDetail?.rating ?? 0)
        guard let name = movieDetail?.name else { return }
        titleLabel.text = "\(String(describing: name))\n\(Constants.star) \(rating)"
    }

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViews()
        setConstraints()
    }

    // MARK: - Private Methods

    private func setViews() {
        backgroundColor = .clear
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        watchButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(movieImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(watchButton)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.widthAnchor.constraint(equalToConstant: 170),
            movieImageView.heightAnchor.constraint(equalToConstant: 200),
            movieImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 51),
            titleLabel.widthAnchor.constraint(equalToConstant: 170),
            titleLabel.heightAnchor.constraint(equalToConstant: 70),
            titleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16),

            watchButton.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 16),
            watchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            watchButton.heightAnchor.constraint(equalToConstant: 48),
            watchButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            watchButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
