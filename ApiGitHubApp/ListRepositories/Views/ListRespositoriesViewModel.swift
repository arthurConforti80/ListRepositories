//
//  listRespositoriesViewModel.swift
//  ApiGitHubApp
//
//  Created by Arthur Conforti on 22/07/2025.
//


import Foundation

protocol ListRespositoriesCoordinatorDelegate: AnyObject {
    func goToPullRequest(repo: String?)
}

protocol ListRespositoriesViewModelProtocol {
    var coordinatorDelegate : ListRespositoriesCoordinatorDelegate? {get set}
}

class ListRespositoriesViewModel: ListRespositoriesViewModelProtocol {
    var coordinatorDelegate: ListRespositoriesCoordinatorDelegate?

    var apiService: APIServiceProtocol = APIService()
    var repositories: [Repository] = []
    var reloadTableView: (() -> Void)?
    var showError: ((String) -> Void)?

    func fetchRepositories() {
        apiService.fetchRepositories(completion: { [weak self] result in
            self?.handleResult(result)
        })
    }
    
    private func handleResult(_ result: Result<[Repository], APIError>) {
        switch result {
        case .success(let data):
            repositories = data
            reloadTableView?()
        case .failure(let error):
            showError?(error.localizedDescription)
        }
    }
    
    func goToSelectedRepo(repo: String?) {
        coordinatorDelegate?.goToPullRequest(repo: repo)
    }
}
