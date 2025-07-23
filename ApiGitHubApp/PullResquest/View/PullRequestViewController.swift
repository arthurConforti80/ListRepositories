//
//  PullRequestViewController.swift
//  ApiGitHubApp
//
//  Created by Arthur Conforti on 22/07/2025.
//

import Foundation

import UIKit


class PullRequestViewController: UIViewController {
    
    var viewModel: PullRequestViewModel?
    private let tableView = UITableView()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Repositorio \(viewModel?.repo ?? "")"
        viewModel?.fetchRepositories()
        setupTableView()
        setupLoadingIndicator()
        setupUI()
        setupBindings()
        loadInitialData()
    }
    

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PullRequestTableViewCell.self, forCellReuseIdentifier: "pullRequestCell")
    }
    
    private func setupLoadingIndicator() {
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator)
    }
    
    private func setupBindings() {
        viewModel?.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.loadingIndicator.stopAnimating()
                self?.tableView.reloadData()
            }
        }
        
        viewModel?.showError = { [weak self] error in
            DispatchQueue.main.async {
                self?.loadingIndicator.stopAnimating()
                let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }
        }
    }
    
    private func loadInitialData() {
        loadingIndicator.startAnimating()
    }
    
}

// MARK: TableView

extension PullRequestViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.repositories.count ?? 0
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pullRequestCell", for: indexPath) as! PullRequestTableViewCell
        cell.configure(model: viewModel?.repositories[indexPath.row])
        return cell
    }
}

extension PullRequestViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
}

extension PullRequestViewController {
    func setupUI() {
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }
}
