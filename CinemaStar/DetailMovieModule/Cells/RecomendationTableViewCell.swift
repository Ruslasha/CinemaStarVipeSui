// RecomendationTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Ячейка с рекомендациями
final class RecomendationsTableViewCell: UITableViewCell {
    // MARK: - Constants

    private enum Constants {
        static let interItemInset = 16.0
        static let cellRatio = 228.0 / 170.0
        static let itemWidth = (UIScreen.main.bounds.width - 3 * Constants.interItemInset) / 2
        static let itemHeight = itemWidth * Constants.cellRatio
    }

    static let reuseId = String(describing: RecomendationsTableViewCell.self)

    // MARK: - Visual Components

    private lazy var movieCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(
            RecomendationCollectionViewCell.self,
            forCellWithReuseIdentifier: RecomendationCollectionViewCell.reuseId
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    // MARK: - Private Properties

    private var similarMovies: [SimilarMovie?]? {
        didSet {
            movieCollectionView.reloadData()
        }
    }

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        setConstraints()
    }

    // MARK: - Public Methods

    func setupCell(movieDetail: MovieDetail?) {
        guard let movieDetail else { return }
        similarMovies = movieDetail.recommendedMovies
    }

    // MARK: - Private Methods

    private func setConstraints() {
        movieCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            movieCollectionView.heightAnchor.constraint(equalToConstant: 250),
            movieCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }

    private func setupViews() {
        backgroundColor = .clear
        contentView.addSubview(movieCollectionView)
    }

    private func makeCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Constants.interItemInset
        layout.itemSize = CGSize(width: Constants.itemWidth, height: Constants.itemHeight)
        return layout
    }
}

// MARK: - Constraints

// MARK: - RecomendationsTableViewCell + UICollectionViewDataSource

extension RecomendationsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        similarMovies?.count ?? 0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecomendationCollectionViewCell.reuseId,
            for: indexPath
        ) as? RecomendationCollectionViewCell else { return .init() }
        cell.setupCell(similarMovie: similarMovies?[indexPath.item])
        return cell
    }
}

// MARK: - RecomendationsTableViewCell + UICollectionViewDelegate

extension RecomendationsTableViewCell: UICollectionViewDelegate {}
