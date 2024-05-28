// TitleHeaderView.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Заголовок ячеек
final class TitleHeaderView: UITableViewHeaderFooterView {
    // MARK: - Constants

    static let reuseId = String(describing: TitleHeaderView.self)

    // MARK: - Visual Components

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .verdana(ofSize: 14)
        label.textColor = .white
        return label
    }()

    // MARK: - Initializers

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setView()
        setConstraint()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
        setConstraint()
    }

    // MARK: - Public Methods

    func setTitle(text: String) {
        titleLabel.text = text
    }

    // MARK: - Private Methods

    private func setView() {
        backgroundColor = .clear
        contentView.addSubview(titleLabel)
    }

    private func setConstraint() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
}
