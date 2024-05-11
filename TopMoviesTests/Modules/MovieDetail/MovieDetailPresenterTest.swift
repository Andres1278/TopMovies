//
//  MovieDetailPresenterTest.swift
//  TopMoviesTests
//
//  Created by Pedro Andres Villamil on 11/05/24.
//

import XCTest
@testable import TopMovies

class MovieDetailPresenterTest: XCTestCase {
    
    fileprivate var sut: MovieDetailPresenter!
    fileprivate var mockView: MockView!
    fileprivate var mockRouter: MockRouter!
    fileprivate var mockInteractor: MockInteractor!
    
    override func setUp() {
        super.setUp()
        mockView = MockView()
        mockRouter = MockRouter()
        mockInteractor = MockInteractor()
        sut = MovieDetailPresenter(
            view: mockView,
            router: mockRouter,
            interactor: mockInteractor,
            model: DummyData.initialModel
        )
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        mockView = nil
        mockRouter = nil
        mockInteractor = nil
    }
    
    func testWhenViewDidLoad() {
        // Given
        // When
        sut.viewDidLoad()
        // Then
        XCTAssertEqual(mockInteractor.invocations, [.getMovieDetaila])
    }
    
    func testWhenGetMovieDetailSuccess() {
        // Given
        // When
        sut.getMoviesDetailSuccess(with: DummyData.movieDetail)
        // Then
        XCTAssertEqual(mockView.invocations, [.configureDetails])
    }
    
    func testWhenGetMovieDetailFails() {
        // Given
        // When
        sut.getMoviesDetailFailure()
        // Then
        XCTAssertEqual(mockRouter.invocations, [.dismiss])
    }
    
    func testWhenUserOpenMovieHomepage() {
        // Given
        sut.movieDetail = DummyData.movieDetail
        // When
        sut.openHomePage()
        // Then
        XCTAssertEqual(mockRouter.invocations, [.openHomePage])
    }
    
    func testWhenUserOpenRaiting() {
        // Given
        sut.movieDetail = DummyData.movieDetail
        // When
        sut.openRaitingAlert()
        // Then
        XCTAssertEqual(mockRouter.invocations, [.showRaitingAlert])
    }
    
    struct DummyData {
        static let initialModel = MovieDetailViewModel(
            id: 42,
            title: "title",
            overview: "overview",
            releaseDate: "releaseDate",
            raiting: "7.5"
        )
        static let movieDetail = MovieDetail(
            budget: 34536456,
            original_title: "original_title",
            overview: "overview",
            popularity: 8,
            release_date: "release_date",
            revenue: 345435435,
            status: "status",
            tagline: "tagline",
            vote_average: 3.4,
            production_countries: [production],
            genres: [genre],
            original_language: "en",
            poster_path: "poster_path",
            title: "test title",
            homepage: "http://www.foxmovies.com/movies/fight-club",
            backdrop_path: "backdrop_path"
        )
        static let genre = Genre(name: "Drama")
        static let production = Production(name: "warner")
    }
    
}

// MARK: - MockView -
extension MovieDetailPresenterTest {
    
    class MockView: MovieDetailViewProtocol {
        var presenter: TopMovies.MovieDetailPresenterProtocol?
        var invocations: [Invocation] = []
        
        enum Invocation: Int {
            case configureDetails
            case updateRaiting
        }
        
        func configureDetails(with movie: TopMovies.MovieDetail) {
            invocations.append(.configureDetails)
        }
        
        func updateRaiting(with raiting: String) {
            invocations.append(.updateRaiting)
        }
    }
}

// MARK: - MockRouter -
extension MovieDetailPresenterTest {
    
    class MockRouter: MovieDetailRouterProtocol {
        
        var invocations: [Invocation] = []
        
        enum Invocation: Int {
            case dismiss
            case openHomePage
            case showRaitingAlert
        }
        
        func dismiss() {
            invocations.append(.dismiss)
        }
        
        func openHomePage(with url: URL) {
            invocations.append(.openHomePage)
        }
        
        func showRaitingAlert(title: String?, subtitle: String?, actionTitle: String?, cancelTitle: String?, inputPlaceholder: String?, inputKeyboardType: UIKeyboardType, cancelHandler: ((UIAlertAction) -> Void)?, actionHandler: ((String?) -> Void)?) {
            invocations.append(.showRaitingAlert)
        }
    }
}

// MARK: - MockInteractor -
extension MovieDetailPresenterTest {
    
    class MockInteractor: MovieDetailInteractorProtocol {
        
        var presenter: MovieDetailInteractorOutputProtocol?
        var invocations: [Invocation] = []
        
        enum Invocation: Int {
            case getMovieDetaila
        }
        
        func getMovieDetaila(with id: String) {
            invocations.append(.getMovieDetaila)
        }
    }
}
