//
//  PullRequestViewModel.swift
//  ApiGitHubApp
//
// Created by Arthur Conforti on 22/07/2025.
//


import Foundation


protocol PullRequestCoordinatorDelegate: AnyObject {}

protocol PullRequestViewModelProtocol {
    var coordinatorDelegate : PullRequestCoordinatorDelegate? {get set}
    var repo: String? { get set }
}

class PullRequestViewModel: PullRequestViewModelProtocol {
    var coordinatorDelegate: PullRequestCoordinatorDelegate?
    var repo: String?
    var apiService: APIServiceProtocol = APIService()
    var repositories: [PullRequestModel] = []
    var reloadTableView: (() -> Void)?
    var showError: ((String) -> Void)?

    func fetchRepositories() {
        apiService.fetchPullRequests(repo: repo, completion: { [weak self] result in
            self?.handleResult(result)
        })
    }
    
    private func handleResult(_ result: Result<[PullRequestModel], APIError>) {
        switch result {
        case .success(let data):
            repositories = data
            reloadTableView?()
        case .failure(let error):
            showError?(error.localizedDescription)
        }
    }
}
