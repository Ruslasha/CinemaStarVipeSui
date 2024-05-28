// LanguageTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с языком
final class LanguageTableViewCell: UITableViewCell {
    // MARK: - Constants

    static let reuseId = String(describing: LanguageTableViewCell.self)

    // MARK: - Visual Components

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .verdana(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
        setConstraints()
    }

    // MARK: - Public Methods

    func setupCell(movieDetail: MovieDetail?) {
        titleLabel.text = movieDetail?.language
    }

    // MARK: - Private Methods

    private func setView() {
        backgroundColor = .clear
        contentView.addSubview(titleLabel)
    }

    private func setConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
