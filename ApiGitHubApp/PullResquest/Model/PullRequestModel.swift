//
//  PullRequestModel.swift
//  ApiGitHubApp
//
//  Created by Arthur Conforti on 22/07/2025.
//

import Foundation

struct PullRequestModel: Codable {
    let id: Int
    let number: Int
    let title: String
    let body: String?
    let state: State
    let user: GitHubUser
    let createdAt: String
    let updatedAt: String
    let mergedAt: String?
    let closedAt: String?
    let mergeCommitSHA: String?
    let htmlURL: String
    let diffURL: String
    let patchURL: String
    let commitsURL: String
    let commentsURL: String
    let reviewCommentsURL: String
    let statusesURL: String
    let head: PullRequestBranch
    let base: PullRequestBranch

    enum CodingKeys: String, CodingKey {
        case id, number, title, body, state, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case mergedAt = "merged_at"
        case closedAt = "closed_at"
        case mergeCommitSHA = "merge_commit_sha"
        case htmlURL = "html_url"
        case diffURL = "diff_url"
        case patchURL = "patch_url"
        case commitsURL = "commits_url"
        case commentsURL = "comments_url"
        case reviewCommentsURL = "review_comments_url"
        case statusesURL = "statuses_url"
        case head, base
    }

    enum State: String, Codable {
        case open
        case closed
    }
}

struct PullRequestBranch: Codable {
    let label: String
    let ref: String
    let sha: String
    let user: GitHubUser
    let repo: GitHubRepo
}

struct GitHubUser: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    let htmlURL: String
    let type: UserType
    let siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
        case type
        case siteAdmin = "site_admin"
    }

    enum UserType: String, Codable {
        case user = "User"
        case organization = "Organization"
    }
}

struct GitHubRepo: Codable {
    let id: Int
    let nodeID: String
    let name: String
    let fullName: String
    let isPrivate: Bool
    let htmlURL: String
    let description: String?
    let fork: Bool
    let language: String?
    let stargazersCount: Int
    let watchersCount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case isPrivate = "private"
        case htmlURL = "html_url"
        case description
        case fork
        case language
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
    }
}
