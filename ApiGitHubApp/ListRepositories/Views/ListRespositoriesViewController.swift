//
//  listRespositoriesViewController.swift
//  ApiGitHubApp
//
//  Created by Arthur Conforti on 22/07/2025.
//

import UIKit

class ListRespositoriesViewController: UIViewController {
    
    var viewModel: ListRespositoriesViewModel?
    var coordinator: AppCoordinator?
    private let tableView = UITableView()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Github Repositories"
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
        tableView.register(ListRepositoriesTableViewCell.self, forCellReuseIdentifier: "repoListCell")
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
       // coordinator?.showPopulationDetails(for: .nation)
    }
    
}

extension ListRespositoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.repositories.count ?? 0
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoListCell", for: indexPath) as! ListRepositoriesTableViewCell
        cell.configure(with: viewModel?.repositories[indexPath.row])
        return cell
    }
}

extension ListRespositoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let repository = viewModel?.repositories[indexPath.row] else { return }
        viewModel?.goToSelectedRepo(repo: repository.fullName)
    }
}

extension ListRespositoriesViewController {
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
