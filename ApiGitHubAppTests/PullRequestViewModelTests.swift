//
//  PullRequestViewModelTests.swift
//  ApiGitHubAppTests
//
//  Created by Arthur Conforti on 22/07/2025.
//

import XCTest
@testable import ApiGitHubApp

final class PullRequestViewModelTests: XCTestCase {

    var viewModel: PullRequestViewModel!
    var mockService: MockGitHubService!

    override func setUp() {
        super.setUp()
        mockService = MockGitHubService()
        viewModel = PullRequestViewModel()
        viewModel.apiService = mockService
    }

    func testFetchPullRequestsSuccess() {
        mockService.shouldFail = false
        viewModel.repo = "Alamofire/Alamofire"
        let expectation = self.expectation(description: "Pull requests loaded")

        viewModel.reloadTableView = {
            XCTAssertEqual(self.viewModel.repositories.count, 1)

            let pr = self.viewModel.repositories.first
            XCTAssertEqual(pr?.id, 2414983536)
            XCTAssertEqual(pr?.number, 3948)
            XCTAssertEqual(pr?.state, .open)
            XCTAssertEqual(pr?.title, "Request Retrying when offline")
            XCTAssertEqual(pr?.user.login, "gouravkmar")
            XCTAssertEqual(pr?.user.avatarURL, "https://avatars.githubusercontent.com/u/40431268?v=4")

            expectation.fulfill()
        }

        viewModel.fetchRepositories()
        waitForExpectations(timeout: 10.0)
    }

    func testFetchPullRequestsFailure() {
        mockService.shouldFail = true
        viewModel = PullRequestViewModel()
        viewModel.apiService = mockService
        viewModel.repo = "apple/swift"

        let expectation = self.expectation(description: "Error callback called")

        viewModel.showError = { errorMessage in
            XCTAssertFalse(errorMessage.isEmpty)
            expectation.fulfill()
        }

        viewModel.fetchRepositories()
        wait(for: [expectation], timeout: 2.0)
    }
}
