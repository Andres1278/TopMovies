//
//  TopListPresenterTest.swift
//  TopMoviesTests
//
//  Created by Pedro Andres Villamil on 10/05/24.
//

import XCTest
@testable import TopMovies

class TopListPresenterTest: XCTestCase {
    
    fileprivate var sut: TopListPresenter!
    fileprivate var mockView: MockView!
    fileprivate var mockRouter: MockRouter!
    fileprivate var mockInteractor: MockInteractor!
    
    override func setUp() {
        super.setUp()
        mockView = MockView()
        mockRouter = MockRouter()
        mockInteractor = MockInteractor()
        sut = TopListPresenter()
        sut.view = mockView
        sut.router = mockRouter
        sut.interactor = mockInteractor
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
        XCTAssertEqual(mockInteractor.invocations, [.getTopMoviesData])
    }
    
    func testWhenShowMovieDetail() {
        // Given
        sut.moviesList = DummyData.topMoviesList.results
        // When
        let index: IndexPath = IndexPath(row: 1, section: 1)
        sut.showMovieDetail(with: index)
        // Then
        XCTAssertEqual(mockRouter.invocations, [.showMovieDetail])
    }
    
    func testWhenUserPullToRefreshData() {
        // Given
        // When
        sut.pullRefreshData()
        // Then
        XCTAssertEqual(mockView.invocations, [.updateMoviesList])
        XCTAssertEqual(mockInteractor.invocations, [.getTopMoviesData])
    }
    
    func testWhenGetMoviesList() {
        // Given
        sut.moviesList = DummyData.topMoviesList.results
        sut.totalMovies = 20
        // When
        sut.getMoviesList()
        // Then
        XCTAssertEqual(mockView.invocations, [.shouldShowActivityIndicator])
        XCTAssertEqual(mockInteractor.invocations, [.getTopMoviesData])
    }
    
    func testWhenGetMovieDetailSuccess() {
        // Given
        // When
        sut.getTopMoviesSuccess(with: DummyData.topMoviesList)
        // Then
        XCTAssertEqual(mockView.invocations, [.updateMoviesList, .shouldShowActivityIndicator])
    }
    
    func testWhenGetMovieDetailFails() {
        // Given
        // When
        sut.getTopMoviesFailure()
        // Then
        XCTAssertEqual(mockView.invocations, [.updateMoviesList, .shouldShowActivityIndicator])
    }
    
    
    struct DummyData {
        
        static let movie = Movie(
            backdropPath: "backdropPath",
            genreIds: [10, 17],
            id: 1,
            originalLanguage: "originalLanguage",
            overview: "overview",
            popularity: 7.8,
            posterPath: "posterPath",
            releaseDate: "releaseDate",
            title: "Test title",
            voteAverage: 5.8
        )
        
        static let topMoviesList = TopMoviesList(
            page: 1,
            totalPages: 10,
            totalResults: 200,
            results: [
                movie,
                movie,
                movie
            ]
        )
    }
    
}

// MARK: - MockView -
extension TopListPresenterTest {
    
    class MockView: TopListViewProtocol {
        
        var presenter: TopMovies.TopListPresenterProtocol?
        var invocations: [Invocation] = []
        
        enum Invocation: Int {
            case updateMoviesList
            case shouldShowActivityIndicator
        }
        
        func updateMoviesList() {
            invocations.append(.updateMoviesList)
        }
        
        func shouldShowActivityIndicator(_ show: Bool) {
            invocations.append(.shouldShowActivityIndicator)
        }
    }
}

// MARK: - MockRouter -
extension TopListPresenterTest {
    
    class MockRouter: TopListRouterProtocol {
        
        var invocations: [Invocation] = []
        
        enum Invocation: Int {
            case showMovieDetail
        }
        
        func showMovieDetail(with model: TopMovies.MovieDetailViewModel) {
            invocations.append(.showMovieDetail)
        }
    }
}

// MARK: - MockInteractor -
extension TopListPresenterTest {
    
    class MockInteractor: TopListInteractorProtocol {
        
        var presenter: TopMovies.TopListInteractorOutputProtocol?
        var invocations: [Invocation] = []
        
        enum Invocation: Int {
            case getTopMoviesData
        }
        
        func getTopMoviesData(with page: Int) {
            invocations.append(.getTopMoviesData)
        }
    }
}
