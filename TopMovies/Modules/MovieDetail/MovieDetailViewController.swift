//
//  MovieDetailViewController.swift
//  TopMovies
//
//  Created by Pedro Andres Villamil on 10/05/24.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    
    private struct Constants {
        static let contentStackSpacing: CGFloat = 16
        static let starIconName: String = "star.fill"
        static let voteStackSpacing: CGFloat = 24
        static let horizontalPadding: CGFloat = CustomSizes.Padding.large.size
        static let starHeight: CGFloat = 42
        static let starWidth: CGFloat = 42
        static let stackBottomPadding: CGFloat = CustomSizes.Padding.normal.size
        static let stackTopPadding: CGFloat = CustomSizes.Padding.normal.size
        static let posterAlpha: CGFloat = 0.3
        static let homePageCopy: String = "Visit Homepage..."
        static let raiting: String = "Vote"
        static let releaseDateHeight: CGFloat = 42
        static let homepageActionButtonHeight: CGFloat = 36
        static let homePageButtonBorder: CGFloat = 1
    }
    
    // MARK: - Public Properties -
    var presenter: MovieDetailPresenterProtocol?
    
    // MARK: - Private Properties -

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = CustomFont.Inter(style: .semiBold(.xLarge)).font
        label.textAlignment = .center
        label.numberOfLines = .zero
        label.textColor = .baseColor100
        return label
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = CustomFont.Inter(style: .medium(.medium)).font
        label.textAlignment = .justified
        label.numberOfLines = .zero
        label.textColor = .baseColor100
        return label
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = CustomFont.Inter(style: .light(.medium)).font
        label.textAlignment = .center
        label.numberOfLines = .zero
        label.textColor = .baseColor100
        return label
    }()
    
    private lazy var starView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.image = UIImage(systemName: Constants.starIconName)?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        return view
    }()
    
    private lazy var starViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.addSubview(starView)
        return view
    }()
    
    private lazy var raitingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = CustomFont.Inter(style: .bold(.xLarge)).font
        label.textColor = .baseColor100
        return label
    }()

    private lazy var raitingStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = Constants.voteStackSpacing
        stack.addArrangedSubview(starViewContainer)
        stack.addArrangedSubview(raitingLabel)
        stack.addArrangedSubview(raitingButton)
        return stack
    }()
    
    lazy var backdropImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .clear
        image.clipsToBounds = true
        image.alpha = Constants.posterAlpha
        return image
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = Constants.contentStackSpacing
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(raitingStackView)
        stack.addArrangedSubview(releaseDateLabel)
        stack.addArrangedSubview(overviewLabel)
        return stack
    }()
    
    private lazy var homePageButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .baseColor900
        button.translatesAutoresizingMaskIntoConstraints = false
        button.round()
        button.setTitle(Constants.homePageCopy, for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = CustomFont.Inter(style: .medium(.medium)).font
        button.addTarget(self, action: #selector(showMovieWebsiteTapped), for: .touchUpInside)
        button.addBorder(color: .baseColor100, width: Constants.homePageButtonBorder)
        return button
    }()
    
    private lazy var raitingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .baseColor900
        button.translatesAutoresizingMaskIntoConstraints = false
        button.round()
        button.setTitle(Constants.raiting, for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = CustomFont.Inter(style: .medium(.medium)).font
        button.addTarget(self, action: #selector(updateRaitingTapped), for: .touchUpInside)
        button.addBorder(color: .baseColor100, width: Constants.homePageButtonBorder)
        return button
    }()
    
    private lazy var imageLoader = ImageLoader()
    
    // MARK: - Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupUI()
        configureDetails()
    }
    
    // MARK: - Private Methods -
    private func setupUI() {
        view.backgroundColor = .black
        addSubviews()
    }
    
    private func addSubviews() {
        
        view.addSubview(backdropImageView)
        view.addSubview(stackView)
        
        let stackBottomConstraint = stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
        stackBottomConstraint.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            
            backdropImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backdropImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backdropImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backdropImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            starView.widthAnchor.constraint(equalToConstant: Constants.starWidth),
            starView.heightAnchor.constraint(equalToConstant: Constants.starHeight),
            starView.topAnchor.constraint(equalTo: starViewContainer.topAnchor),
            starView.bottomAnchor.constraint(equalTo: starViewContainer.bottomAnchor),
            starView.trailingAnchor.constraint(equalTo: starViewContainer.trailingAnchor),
            
            releaseDateLabel.heightAnchor.constraint(equalToConstant: Constants.releaseDateHeight),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.horizontalPadding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.horizontalPadding),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.stackTopPadding),
            stackBottomConstraint,
        ])
        
    }
    
    private func configureDetails() {
        guard let model = presenter?.model else { return }
        titleLabel.text = model.title
        overviewLabel.text = model.overview
        raitingLabel.text = model.raiting
        releaseDateLabel.text = model.releaseDate
    }
    
    private func loadPoster(with path: String) {
        imageLoader.downloadImageWithPath(
            imagePath: API.posterURL(for: .poster(path: path)),
            isFromDetail: true
        ) { [weak self] image in
            guard let self, let image else { return }
            self.backdropImageView.image = image
        }
    }
    
    private func configureHomepageActionIfPosible() {
        if let presenter,
           presenter.hasValidHomePageURL {
            view.addSubview(homePageButton)
            
            NSLayoutConstraint.activate([
                homePageButton.heightAnchor.constraint(equalToConstant: Constants.homepageActionButtonHeight),
                homePageButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
                homePageButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
                homePageButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.stackBottomPadding)
            ])
        }
    }
    
    // MARK: - Actions -
    @objc private func showMovieWebsiteTapped() {
        presenter?.openHomePage()
    }
    
    @objc private func updateRaitingTapped() {
        presenter?.openRaitingAlert()
    }
}

// MARK: - MovieDetailViewProtocol -
extension MovieDetailViewController: MovieDetailViewProtocol {
    
    func configureDetails(with movie: MovieDetail) {
        loadPoster(with: movie.backdrop_path)
        configureHomepageActionIfPosible()
    }
    
    func updateRaiting(with raiting: String) {
        raitingLabel.text = raiting
    }
}
