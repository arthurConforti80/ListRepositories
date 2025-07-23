//
//  PullRequestTableViewCell.swift
//  ApiGitHubApp
//
//  Created by Arthur Conforti on 22/07/2025.
//

import Foundation
import UIKit

class PullRequestTableViewCell: UITableViewCell {
    
    // MARK: - Views
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()
    
    private let avatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "person.crop.circle")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 20
        iv.tintColor = .gray
        return iv
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private let userSubtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = .systemFont(ofSize: 12)
        label.text = "Nome Sobrenome"
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup

    private func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(bodyLabel)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(userSubtitleLabel)
    }

    private func setupConstraints() {
        [titleLabel, bodyLabel, avatarImageView, usernameLabel, userSubtitleLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            bodyLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            avatarImageView.topAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 8),
            avatarImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 40),
            avatarImageView.heightAnchor.constraint(equalToConstant: 40),
            avatarImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 8),
            usernameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16),
            
            userSubtitleLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 2),
            userSubtitleLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            userSubtitleLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor)
        ])
    }
    
    func configure(model: PullRequestModel?) {
        titleLabel.text = model?.title
        bodyLabel.text = model?.body
        usernameLabel.text = model?.user.login
    }
}
