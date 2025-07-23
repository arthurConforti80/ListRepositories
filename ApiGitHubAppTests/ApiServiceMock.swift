//
//  ApiServiceMock.swift
//  ApiGitHubAppTests
//
//  Created by ITSECTOR on 23/07/2025.
//

import Foundation
@testable import ApiGitHubApp

protocol PullRequestServiceProtocol {
    func fetchRepositories(completion: @escaping (Result<[Repository], APIError>) -> Void)
    func fetchPullRequests(repo: String?, completion: @escaping (Result<[PullRequestModel], APIError>) -> Void)
}

class MockPullRequestService: PullRequestServiceProtocol {
    var shouldReturnError = false
    var mockDataRepositorie: [Repository] = []
    var mockDataPullRequest: [PullRequestModel] = []
    
    func fetchRepositories(completion: @escaping (Result<[Repository], APIError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.failedRequest))
        } else {
            completion(.success(mockDataRepositorie))
        }
    }

    func fetchPullRequests(repo: String?, completion: @escaping (Result<[PullRequestModel], APIError>) -> Void) {
        if shouldReturnError {
            completion(.failure(.failedRequest))
        } else {
            completion(.success(mockDataPullRequest))
        }
    }
}
