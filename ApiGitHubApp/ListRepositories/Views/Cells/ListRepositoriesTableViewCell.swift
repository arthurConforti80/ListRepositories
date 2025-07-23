//
//  listRepositoriesTableViewCell.swift
//  ApiGitHubApp
//
//  Created by Arthur Conforti on 22/07/2025.
//

import UIKit

class ListRepositoriesTableViewCell: UITableViewCell {

    private let repoNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()

    private let forksLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.orange
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()

    private let starsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.systemOrange
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()

    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .gray
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 24
        return imageView
    }()

    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()

    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        layoutConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(repoNameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(forksLabel)
        contentView.addSubview(starsLabel)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(fullNameLabel)
    }

    private func layoutConstraints() {
        repoNameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        forksLabel.translatesAutoresizingMaskIntoConstraints = false
        starsLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Repo title
            repoNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            repoNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            repoNameLabel.trailingAnchor.constraint(equalTo: avatarImageView.leadingAnchor, constant: -8),

            // Description
            descriptionLabel.topAnchor.constraint(equalTo: repoNameLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: repoNameLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: repoNameLabel.trailingAnchor, constant: -10),

            // Forks & Stars
            forksLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            forksLabel.leadingAnchor.constraint(equalTo: repoNameLabel.leadingAnchor),

            starsLabel.centerYAnchor.constraint(equalTo: forksLabel.centerYAnchor),
            starsLabel.leadingAnchor.constraint(equalTo: forksLabel.trailingAnchor, constant: 16),

            // Avatar
            avatarImageView.topAnchor.constraint(equalTo: repoNameLabel.topAnchor),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            avatarImageView.widthAnchor.constraint(equalToConstant: 48),
            avatarImageView.heightAnchor.constraint(equalToConstant: 48),

            // Username
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 4),
            usernameLabel.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor),

            // Full name
            fullNameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 2),
            fullNameLabel.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor),
            fullNameLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    func configure(with repo: Repository?) {
        repoNameLabel.text = repo?.name
        descriptionLabel.text = repo?.description
        starsLabel.text = "⭐️ \(repo?.stargazersCount ?? 0)"
        usernameLabel.text = repo?.owner.login
        fullNameLabel.text = "Nome Sobrenome"

        if let forkImage = UIImage(systemName: "tuningfork") {
            let attachment = NSTextAttachment()
            attachment.image = forkImage
            attachment.bounds = CGRect(x: 0, y: -2, width: 16, height: 16)

            let imageString = NSAttributedString(attachment: attachment)
            let forksCountString = NSAttributedString(string: " \(repo?.forksCount ?? 0)")

            let final = NSMutableAttributedString()
            final.append(imageString)
            final.append(forksCountString)

            forksLabel.attributedText = final
        } else {
            forksLabel.text = "🍴 \(repo?.forksCount ?? 0)"
        }
    }
}
