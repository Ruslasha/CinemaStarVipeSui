// ActorsTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с актерами
final class ActorsTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let interItemInset = 22.0
        static let cellRatio = 97.0 / 46.0
        static let itemWidth = (UIScreen.main.bounds.width - 6 * Constants.interItemInset) / 5
        static let itemHeight = itemWidth * Constants.cellRatio
    }

    static let reuseId = String(describing: ActorsTableViewCell.self)

    // MARK: - Visual Components

    private lazy var actorsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(
            ActorsCollectionViewCell.self,
            forCellWithReuseIdentifier: ActorsCollectionViewCell.reuseId
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    // MARK: - Public Properties

    // MARK: - Private Properties

    private var actors: [Person]? {
        didSet {
            actorsCollectionView.reloadData()
        }
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

    // MARK: - Public Methods

    func setupCell(movieDetail: MovieDetail?) {
        actors = movieDetail?.actors
    }

    // MARK: - Private Methods

    private func setViews() {
        backgroundColor = .clear
        contentView.addSubview(actorsCollectionView)
    }

    private func makeCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Constants.interItemInset
        layout.itemSize = CGSize(width: Constants.itemWidth, height: Constants.itemHeight)
        return layout
    }

    private func setConstraints() {
        actorsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            actorsCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            actorsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            actorsCollectionView.heightAnchor.constraint(equalToConstant: 110),
            actorsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            actorsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}

// MARK: - ActorsTableViewCell + UICollectionViewDataSource

extension ActorsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        actors?.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ActorsCollectionViewCell.reuseId,
            for: indexPath
        ) as? ActorsCollectionViewCell else { return .init() }
        cell.setupCell(actorName: actors?[indexPath.item])
        return cell
    }
}

// MARK: - ActorsTableViewCell + UICollectionViewDelegate

extension ActorsTableViewCell: UICollectionViewDelegate {}
