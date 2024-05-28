// DetailMovieViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Экран с деталями
final class DetailMovieViewController: UIViewController {
    // MARK: - Types

    private enum SectionType {
        case title
        case description
        case actors
        case language
        case recomendations

        var headerTitle: String? {
            switch self {
            case .actors:
                return "Актеры и съемочная группа "
            case .language:
                return "Язык"
            case .recomendations:
                return "Смотрите также"
            default:
                return nil
            }
        }

        var sectionCellType: UITableViewCell {
            switch self {
            case .title:
                return HeaderTableViewCell()
            case .description:
                return DescriptionTableViewCell()
            case .actors:
                return ActorsTableViewCell()
            case .language:
                return LanguageTableViewCell()
            case .recomendations:
                return RecomendationsTableViewCell()
            }
        }
    }

    // MARK: - Visual Components

    private lazy var mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TitleHeaderView.self, forHeaderFooterViewReuseIdentifier: TitleHeaderView.reuseId)
        return tableView
    }()

    // MARK: - Private Properties

    private let sections: [SectionType] = [.title, .description, .actors, .language, .recomendations]
    private var viewModel: DetailMovieViewModel?
    private let id: Int
    private var movieDetail: MovieDetail? {
        didSet {
            mainTableView.reloadData()
        }
    }

    private var isTextExpended = false

    init(id: Int, viewModel: DetailMovieViewModel) {
        self.id = id
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        id = 0
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupGradient()
        setView()
        getMovieDetail()
    }

    private func getMovieDetail() {
        viewModel?.getDetailedMovie(by: id) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(movieDetail):
                    self.movieDetail = movieDetail
                case let .failure(error):
                    print(error)
                }
            }
        }
    }

    private func setView() {
        navigationController?.navigationBar.tintColor = .white

        view.addSubview(mainTableView)
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.topAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ])
    }

    private func setupGradient() {
        let gradient = CAGradientLayer()
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.frame = view.bounds
        gradient.colors = [
            UIColor(red: 179 / 255, green: 141 / 255, blue: 87 / 255, alpha: 0.51).cgColor,
            UIColor(red: 43 / 255, green: 81 / 255, blue: 74 / 255, alpha: 1).cgColor,
        ]
        view.layer.insertSublayer(gradient, at: 0)
    }
}

// MARK: - DetailMovieViewController + UITableViewDataSource

extension DetailMovieViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sections[indexPath.section].sectionCellType
        if let cell = cell as? HeaderTableViewCell {
            cell.setupCell(movieDetail: movieDetail)
        } else if let cell = cell as? DescriptionTableViewCell {
            cell.onReload = {
                self.isTextExpended.toggle()
                tableView.reloadData()
            }
            cell.setupCell(movieDetail: movieDetail, isTextExpended: isTextExpended)
        } else if let cell = cell as? ActorsTableViewCell {
            cell.setupCell(movieDetail: movieDetail)
        } else if let cell = cell as? LanguageTableViewCell {
            cell.setupCell(movieDetail: movieDetail)
        } else if let cell = cell as? RecomendationsTableViewCell {
            cell.setupCell(movieDetail: movieDetail)
        }
        return cell
    }
}

// MARK: - DetailMovieViewController + UITableViewDelegate

extension DetailMovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerTitle = sections[section].headerTitle,
              let view = tableView
              .dequeueReusableHeaderFooterView(withIdentifier: TitleHeaderView.reuseId) as? TitleHeaderView
        else { return nil }
        view.setTitle(text: headerTitle)
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if sections[section].headerTitle != nil {
            return 35
        }
        return 0
    }
}
