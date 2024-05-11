//
//  TopListViewController.swift
//  TopMovies
//
//  Created by Pedro Andres Villamil on 6/05/24.
//

import UIKit

enum Sections: CaseIterable {
    case list
    case favorites
}

struct Items: Hashable {
    let id = UUID()
    let movie: Movie
}

final class TopListViewController: UIViewController {
    
    private struct Constants {
        static let cellHeight: CGFloat = 220
        static let tableViewBottomInset: CGFloat = 80
        static let actitivyHeight: CGFloat = 70
        static let title: String = "Top Movies"
        static let transitionDuration: TimeInterval = 0.6
    }
    
    // MARK: - Public Properties -
    var presenter: TopListPresenterProtocol?
    
    // MARK: - Private Properties -
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieListCellTableViewCell.self, forCellReuseIdentifier: MovieListCellTableViewCell.name)
        tableView.refreshControl = refreshControl
        return tableView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .baseColor100
        indicator.startAnimating()
        return indicator
    }()
    
    private lazy var activityIndicatorContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.addSubview(activityIndicator)
        return view
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullRefreshAction), for: .valueChanged)
        refreshControl.tintColor = .baseColor100
        return refreshControl
    }()
    
    private lazy var imageLoader = ImageLoader()
    private lazy var isInANetworkRequest: Bool = false

    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Private Methods -
    private func setupUI() {
        view.backgroundColor = .black
        configureNavigationBar()
        addSubviews()
    }
    
    
    private func addSubviews() {
        view.addSubview(activityIndicatorContainer)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicatorContainer.heightAnchor.constraint(equalToConstant: Constants.actitivyHeight),
            activityIndicatorContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activityIndicatorContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            activityIndicatorContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: activityIndicatorContainer.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: activityIndicatorContainer.centerYAnchor)
        ])
        
    }
    
    private func configureNavigationBar() {
        title = Constants.title
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.baseColor100
        ]
    }
    
    @objc private func pullRefreshAction() {
        presenter?.pullRefreshData()
    }
    
    // MARK: - Public Methods -
    
    
}

// MARK: - UIScrollViewDelegate -
extension TopListViewController: UIScrollViewDelegate {

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        shouldShowActivityIndicator(false)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if presenter?.isEndOfTableView(scrollView) ?? false,
           !isInANetworkRequest {
            presenter?.getMoviesList()
            isInANetworkRequest = true
        } else {
            isInANetworkRequest = false
        }
    }
}


// MARK: - UITableViewDelegate -
extension TopListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showMovieDetail(with: indexPath)
    }
}

// MARK: - UITableViewDelegate -
extension TopListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.moviesList.count ?? .zero
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = presenter?.getMovieCellViewModel(at: indexPath),
              let cell = tableView.dequeueReusableCell(withIdentifier: MovieListCellTableViewCell.name, for: indexPath) as? MovieListCellTableViewCell else {
            return UITableViewCell()
        }
        
        imageLoader.downloadImageWithPath(
            imagePath: API.posterURL(for: .poster(path: model.posterPath))
        ) { image in
            if let cell = tableView.cellForRow(at: indexPath) as? MovieListCellTableViewCell {
                cell.posterImage.image = image
            }
        }
        
        cell.configure(with: model)
        return cell
    }
}

// MARK: - TopListViewProtocol -
extension TopListViewController: TopListViewProtocol {

    func updateMoviesList() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    func shouldShowActivityIndicator(_ show: Bool) {
        if let moviesCount = presenter?.moviesList.count,
           moviesCount > .zero {
            Task {
                self.activityIndicator.isHidden = !show
                UIView.transition(
                    with: self.activityIndicatorContainer,
                    duration: Constants.transitionDuration,
                    options: .transitionCrossDissolve,
                    animations: {
                        self.activityIndicatorContainer.isHidden = !show
                    },
                    completion: nil
                )
                self.tableView.contentInset = UIEdgeInsets(
                    top: .zero,
                    left: .zero,
                    bottom: show ? Constants.tableViewBottomInset : .zero,
                    right: .zero
                )
                show ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
            }
        }
    }
}
