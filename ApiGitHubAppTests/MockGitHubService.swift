//
//  MockGitHubService.swift
//  ApiGitHubAppTests
//
//  Created by Arthur Conforti on 22/07/2025.
//

import Foundation
@testable import ApiGitHubApp


class MockGitHubService: APIServiceProtocol {
    
    var shouldFail = false
    
    
    func fetchRepositories(completion: @escaping (Result<[Repository], APIError>) -> Void) {
        if shouldFail {
            completion(.failure(.failedRequest))
            return
        }

        let mockJSON = """
        {
          "total_count": 2,
          "incomplete_results": false,
          "items": [
            {
              "id": 123,
              "name": "swift",
              "full_name": "apple/swift",
              "description": "The Swift Programming Language",
              "html_url": "https://github.com/apple/swift",
              "language": "Swift",
              "stargazers_count": 60000,
              "forks_count": 15000,
              "owner": {
                "login": "apple",
                "avatar_url": "https://avatars.githubusercontent.com/u/10639145?v=4"
              }
            }
          ]
        }
        """.data(using: .utf8)!

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decoded = try decoder.decode(listRespositoriesResponse.self, from: mockJSON)
            completion(.success(decoded.items))
        } catch {
            completion(.failure(.invalidResponse))
        }
    }

    
    func fetchPullRequests(repo: String?, completion: @escaping (Result<[PullRequestModel], APIError>) -> Void) {
        let mockJSON = """
        [
            {
                "id": 2414983536,
                "number": 3948,
                "state": "open",
                "title": "Request Retrying when offline",
                "body": "Issue Link :link:\\nNo specific issue was raised...",
                "user": {
                    "login": "gouravkmar",
                    "avatar_url": "https://avatars.githubusercontent.com/u/40431268?v=4"
                }
            }
        ]
        """.data(using: .utf8)!

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let pullRequests = try decoder.decode([PullRequestModel].self, from: mockJSON)
            completion(.success(pullRequests))
        } catch {
            completion(.failure(APIError.invalidResponse))
        }
    }
}
