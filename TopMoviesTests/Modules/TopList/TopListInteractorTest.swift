//
//  TopListInteractorTest.swift
//  TopMoviesTests
//
//  Created by Pedro Andres Villamil on 10/05/24.
//

import XCTest
@testable import TopMovies

class TopListInteractorTest: XCTestCase {
    
    fileprivate var sut: TopListInteractor!
    fileprivate var mockPresenter: MockPresenter!
    fileprivate var topMoviesListJson = "TopMoviesList"
    
    override func setUp() {
        super.setUp()
        mockPresenter = MockPresenter()
        sut = TopListInteractor()
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
        MockNetworkingManager.share.createMockeSesion(from: topMoviesListJson, statusCode: 200) { [weak self] (response: ServiceManger.CompletionResult<TopMoviesList>) in
            guard let self else { return }
            switch response {
            case .success(let data):
                sut.presenter?.getTopMoviesSuccess(with: data)
                // Then
                XCTAssertEqual(mockPresenter.invocations, [.getTopMoviesSuccess])
            case .failure:
                sut.presenter?.getTopMoviesFailure()
            }
        }
    }
    
    func testGetMovieListFailure() {
        // Given
        // When
        MockNetworkingManager.share.createMockeSesion(from: topMoviesListJson, statusCode: 400) { [weak self] (response: MockNetworkingManager.CompletionResult<TopMoviesList>) in
            guard let self else { return }
            switch response {
            case .success(let data):
                sut.presenter?.getTopMoviesSuccess(with: data)
            case .failure:
                sut.presenter?.getTopMoviesFailure()
                // Then
                XCTAssertEqual(mockPresenter.invocations, [.getTopMoviesFailure])
            }
        }
    }
    
}

// MARK: - MockPresenter -
extension TopListInteractorTest {
    
    class MockPresenter: TopListInteractorOutputProtocol {
        
        var invocations: [Invocation] = []
        
        enum Invocation: Int {
            case getTopMoviesSuccess
            case getTopMoviesFailure
        }
        
        func getTopMoviesSuccess(with response: TopMovies.TopMoviesList) {
            invocations.append(.getTopMoviesSuccess)
        }
        
        func getTopMoviesFailure() {
            invocations.append(.getTopMoviesFailure)
        }
    }
}

