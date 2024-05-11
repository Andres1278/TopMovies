//
//  MovieListCellTableViewCell.swift
//  TopMovies
//
//  Created by Pedro Andres Villamil on 6/05/24.
//

import UIKit

struct MovieLisCellViewModel {
    
    let title: String
    let voteAverage: String
    let posterPath: String
    let releaseDate: String
    
    static func getMovieListCellViewModel(from data: Movie) -> Self {
        .init(
            title: data.title,
            voteAverage: String(format: "%.1f", data.voteAverage),
            posterPath: data.posterPath,
            releaseDate: data.releaseDate
        )
    }
}

class MovieListCellTableViewCell: UITableViewCell {
    
    private struct Constants {
        static let posterImageWidth: CGFloat = 120
        static let smallPadding: CGFloat = CustomSizes.Padding.small.size
        static let mediumPadding: CGFloat = CustomSizes.Padding.medium.size
        static let largePadding: CGFloat = CustomSizes.Padding.large.size
        static let extraLargePadding: CGFloat = CustomSizes.Padding.xLarge.size
        static let titleNumberOfLines: Int = 2
        static let voteStackSpacing: CGFloat = 16
        static let contentStackSpacing: CGFloat = 8
        static let starIconName: String = "star.fill"
        static let releaseDateHeight: CGFloat = 20
        static let starWidth: CGFloat = 20
        static let cardShadowRadius: CGFloat = 5
        static let cardBorderWidth: CGFloat = 2
        static let cardShadowOpacity: Float = 0.5
    }
    
    // MARK: - Public Properties -
    
    
    
    // MARK: - Private Properties -
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = CustomFont.Inter(style: .medium(.normal)).font
        label.textAlignment = .center
        label.numberOfLines = Constants.titleNumberOfLines
        label.textColor = .baseColor100
        return label
    }()
    
    private lazy var voteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = CustomFont.Inter(style: .bold(.medium)).font
        label.textColor = .baseColor100
        return label
    }()
    
    private lazy var releaseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = CustomFont.Inter(style: .light(.xSmall)).font
        label.textAlignment = .right
        label.textColor = .baseColor100
        return label
    }()
    
    private lazy var starView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.image = UIImage(systemName: Constants.starIconName)?.withTintColor(.baseColor500, renderingMode: .alwaysOriginal)
        return view
    }()
    
    private lazy var starViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.addSubview(starView)
        return view
    }()
    
    private lazy var voteStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = Constants.voteStackSpacing
        stack.addArrangedSubview(starViewContainer)
        stack.addArrangedSubview(voteLabel)
        return stack
    }()

    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = Constants.contentStackSpacing
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(voteStackView)
        stack.addArrangedSubview(releaseLabel)
        return stack
    }()
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.cornerRadius = .cardCornerRadius
        view.addBorder(color: .baseColor500, width: Constants.cardBorderWidth)
        return view
    }()
    
    lazy var posterImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .baseColor100
        image.round()
        return image
    }()
    
    // MARK: - Lifecycle -

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        posterImage.image = nil
    }
    
    // MARK: - Private Methods -
    private func setupUI() {
        addSubViews()
        contentView.backgroundColor = .black
    }
    
    private func addSubViews() {
        contentView.addSubview(cardView)
        contentView.addSubview(stackView)
        contentView.addSubview(posterImage)
        
        
        NSLayoutConstraint.activate([
            
            releaseLabel.heightAnchor.constraint(equalToConstant: Constants.releaseDateHeight),
            
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.mediumPadding),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.mediumPadding),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.largePadding),
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.extraLargePadding),
            
            posterImage.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Constants.smallPadding),
            posterImage.topAnchor.constraint(equalTo: topAnchor),
            posterImage.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -Constants.smallPadding),
            posterImage.widthAnchor.constraint(equalToConstant: Constants.posterImageWidth),
            
            stackView.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: Constants.smallPadding),
            stackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Constants.smallPadding),
            stackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: Constants.smallPadding),
            stackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -Constants.smallPadding),
            
            starView.widthAnchor.constraint(equalToConstant: Constants.starWidth),
            starView.topAnchor.constraint(equalTo: starViewContainer.topAnchor),
            starView.bottomAnchor.constraint(equalTo: starViewContainer.bottomAnchor),
            starView.trailingAnchor.constraint(equalTo: starViewContainer.trailingAnchor)
        ])
    }
    
    private func addCardShadow() {
        cardView.layer.shadowColor = UIColor.lightGray.cgColor
        cardView.layer.shadowOpacity = Constants.cardShadowOpacity
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowRadius = Constants.cardShadowRadius
        cardView.layer.shadowPath = UIBezierPath(rect: cardView.bounds).cgPath
        cardView.layer.shouldRasterize = true
        cardView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    // MARK: - Public Methods -
    
    func configure(with model: MovieLisCellViewModel) {
        titleLabel.text = model.title
        voteLabel.text = model.voteAverage
        releaseLabel.text = model.releaseDate
        addCardShadow()
    }
}
