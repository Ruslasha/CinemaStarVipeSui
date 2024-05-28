// DescriptionTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с описанием
final class DescriptionTableViewCell: UITableViewCell {
    // MARK: - Constants

    static let reuseId = String(describing: DescriptionTableViewCell.self)

    // MARK: - Visual Components

    var onReload: (() -> ())?

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .verdana(ofSize: 14)
        return label
    }()

    private lazy var textHiddenButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.addTarget(self, action: #selector(textHiddenButtonDidTapped), for: .touchUpInside)
        return button
    }()

    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .verdana(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()

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

    // MARK: - Public Methods

    func setupCell(movieDetail: MovieDetail?, isTextExpended: Bool) {
        guard let movieDetail else { return }
        if isTextExpended {
            descriptionLabel.numberOfLines = 0
            textHiddenButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        } else {
            descriptionLabel.numberOfLines = 5
            textHiddenButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        }
        descriptionLabel.text = movieDetail.description
        let year = movieDetail.year
        let country = movieDetail.country
        let type = movieDetail.type.typeDescription
        detailsLabel.text = "\(year) / \(country) / \(type)"
    }

    // MARK: - Private Methods

    private func setViews() {
        backgroundColor = .clear
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        detailsLabel.translatesAutoresizingMaskIntoConstraints = false
        textHiddenButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(textHiddenButton)
        contentView.addSubview(detailsLabel)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -36),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),

            textHiddenButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: -20),
            textHiddenButton.heightAnchor.constraint(lessThanOrEqualToConstant: 20),
            textHiddenButton.widthAnchor.constraint(lessThanOrEqualToConstant: 20),
            textHiddenButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            detailsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            detailsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            detailsLabel.heightAnchor.constraint(equalToConstant: 20),
            detailsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            detailsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    @objc private func textHiddenButtonDidTapped() {
        descriptionLabel.numberOfLines = 0
        onReload?()
    }
}
