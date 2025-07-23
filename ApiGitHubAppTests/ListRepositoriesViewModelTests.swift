//
//  ListRepositoriesViewModelTests.swift
//  ApiGitHubAppTests
//
//  Created by Arthur Conforti on 22/07/2025.
//
import XCTest
@testable import ApiGitHubApp

final class ListRespositoriesViewModelTests: XCTestCase {

    var viewModel: ListRespositoriesViewModel!
    var mockService: MockGitHubService!

    override func setUp() {
        super.setUp()
        mockService = MockGitHubService()
        viewModel = ListRespositoriesViewModel()
    }

    func testFetchRepositoriesReturnsExpectedData() {
        let expectation = self.expectation(description: "Repositories loaded")

        viewModel.reloadTableView = {
            XCTAssertEqual(self.viewModel.repositories.count, 30)

            let repo = self.viewModel.repositories.first
            XCTAssertEqual(repo?.id, 21700699)
            XCTAssertEqual(repo?.name, "awesome-ios")
            XCTAssertEqual(repo?.fullName, "vsouza/awesome-ios")
            XCTAssertEqual(repo?.language, "Swift")
            XCTAssertEqual(repo?.stargazersCount, 49456)
            XCTAssertEqual(repo?.owner.login, "vsouza")
            XCTAssertEqual(repo?.owner.avatarURL, "https://avatars.githubusercontent.com/u/484656?v=4")

            expectation.fulfill()
        }

        viewModel.fetchRepositories()
        waitForExpectations(timeout: 1.0)
    }
    
    func testFetchListFailure() {
        mockService.shouldFail = true
        viewModel = ListRespositoriesViewModel()
        viewModel.apiService = mockService

        let expectation = self.expectation(description: "Error callback called")

        viewModel.showError = { errorMessage in
            XCTAssertFalse(errorMessage.isEmpty)
            expectation.fulfill()
        }

        viewModel.fetchRepositories()
        wait(for: [expectation], timeout: 2.0)
    }
}
