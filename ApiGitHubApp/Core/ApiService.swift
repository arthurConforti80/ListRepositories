//
//  ApiService.swift
//  CensusUSA
//
//  Created by Arthur Conforti on 28/08/2024.
//

import Alamofire

enum APIError: Error {
    case invalidResponse
    case noData
    case failedRequest
    case invalidURL
}

protocol APIServiceProtocol {
    func fetchRepositories(completion: @escaping (Result<[Repository], APIError>) -> Void)
    func fetchPullRequests(repo: String?, completion: @escaping (Result<[PullRequestModel], APIError>) -> Void)
}

class APIService: APIServiceProtocol {
    
    func fetchRepositories(completion: @escaping (Result<[Repository], APIError>) -> Void) {
        let url = "https://api.github.com/search/repositories?q=language:Swift&sort=stars&page=1"
        AF.request(url).responseDecodable(of: listRespositoriesResponse.self) { response in
            switch response.result {
            case .success(let apiResponse):
                let repositories = apiResponse.items
                completion(.success(apiResponse.items))
            case .failure(let error):
                completion(.failure(.failedRequest))
            }
        }
    }
    
    
    func fetchPullRequests(repo: String?, completion: @escaping (Result<[PullRequestModel], APIError>) -> Void) {
        guard let repo = repo, !repo.isEmpty else {
            completion(.failure(.invalidURL))
            return
        }
        let url = "https://api.github.com/repos/\(repo)/pulls"
        AF.request(url)
            .validate()
            .responseDecodable(of: [PullRequestModel].self) { response in
                switch response.result {
                case .success(let pullRequests):
                    completion(.success(pullRequests))
                case .failure:
                    completion(.failure(.failedRequest))
                }
            }
    }
}
