//
//  MovieDetailInteractorTest.swift
//  TopMoviesTests
//
//  Created by Pedro Andres Villamil on 11/05/24.
//

import XCTest
@testable import TopMovies

class MovieDetailInteractorTest: XCTestCase {
    
    fileprivate var sut: MovieDetailInteractor!
    fileprivate var mockPresenter: MockPresenter!
    fileprivate var movieDetail = "MovieDetail"
    
    override func setUp() {
        super.setUp()
        mockPresenter = MockPresenter()
        sut = MovieDetailInteractor()
        sut.presenter = mockPresenter
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        mockPresenter = nil
    }
    
    func testGetMovieListSuccess() {
        // Given
        // When
        MockNetworkingManager.share.createMockeSesion(from: movieDetail, statusCode: 200) { [weak self] (response: MockNetworkingManager.CompletionResult<MovieDetail>) in
            guard let self else { return }
            switch response {
            case .success(let data):
                sut.presenter?.getMoviesDetailSuccess(with: data)
                // Then
                XCTAssertEqual(mockPresenter.invocations, [.getMoviesDetailSuccess])
            case .failure:
                sut.presenter?.getMoviesDetailFailure()
            }
        }
    }
    
    func testGetMovieListFailure() {
        // Given
        // When
        MockNetworkingManager.share.createMockeSesion(from: movieDetail, statusCode: 400) { [weak self] (response: MockNetworkingManager.CompletionResult<MovieDetail>) in
            guard let self else { return }
            switch response {
            case .success(let data):
                sut.presenter?.getMoviesDetailSuccess(with: data)
            case .failure:
                sut.presenter?.getMoviesDetailFailure()
                // Then
                XCTAssertEqual(mockPresenter.invocations, [.getMoviesDetailFailure])
            }
        }
    }
    
}

// MARK: - MockPresenter -
extension MovieDetailInteractorTest {
    
    class MockPresenter: MovieDetailInteractorOutputProtocol {
        
        var invocations: [Invocation] = []
        
        enum Invocation: Int {
            case getMoviesDetailSuccess
            case getMoviesDetailFailure
        }
        
        func getMoviesDetailSuccess(with response: TopMovies.MovieDetail) {
            invocations.append(.getMoviesDetailSuccess)
        }
        
        func getMoviesDetailFailure() {
            invocations.append(.getMoviesDetailFailure)
        }
    }
}


