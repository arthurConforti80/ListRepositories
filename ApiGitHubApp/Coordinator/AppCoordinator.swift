//
//  AppCoordinator.swift
//  CensusUSA
//
//  Created by Arthur Conforti on 28/08/2024.
//
import UIKit

class AppCoordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let listRespositoriesViewController = ListRespositoriesViewController()
        let viewModel = ListRespositoriesViewModel()
        viewModel.coordinatorDelegate = self
        listRespositoriesViewController.viewModel = viewModel
        navigationController.pushViewController(listRespositoriesViewController, animated: true)
    }
    
    func startPullRequest(repo: String?) {
        let pullRequestViewController = PullRequestViewController()
        let viewModel = PullRequestViewModel()
        viewModel.repo = repo
        viewModel.coordinatorDelegate = self
        pullRequestViewController.viewModel = viewModel
        navigationController.pushViewController(pullRequestViewController, animated: true)
    }

}


extension AppCoordinator: ListRespositoriesCoordinatorDelegate {
    func goToPullRequest(repo: String?) {
        startPullRequest(repo: repo)
    }
}

extension AppCoordinator: PullRequestCoordinatorDelegate {
    // Implement any methods needed for PullRequestCoordinatorDelegate
}
