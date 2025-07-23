//
//  listRespositoriesModel.swift
//  ApiGitHubApp
//
//  Created by Arthur Conforti on 22/07/2025.
//

import Foundation

struct listRespositoriesResponse: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Repository]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

struct Repository: Codable {
    let id: Int
    let nodeID: String
    let name: String
    let fullName: String
    let isPrivate: Bool
    let owner: Owner
    let htmlURL: String
    let description: String?
    let fork: Bool
    let url: String
    let createdAt: String
    let updatedAt: String
    let pushedAt: String
    let homepage: String?
    let size: Int
    let stargazersCount: Int
    let watchersCount: Int
    let language: String?
    let hasIssues: Bool
    let hasProjects: Bool
    let hasDownloads: Bool
    let hasWiki: Bool
    let hasPages: Bool
    let hasDiscussions: Bool
    let forksCount: Int
    let mirrorURL: String?
    let archived: Bool
    let disabled: Bool
    let openIssuesCount: Int
    let license: License?
    let allowForking: Bool
    let isTemplate: Bool
    let webCommitSignoffRequired: Bool
    let topics: [String]
    let visibility: Visibility
    let forks: Int
    let openIssues: Int
    let watchers: Int
    let defaultBranch: String
    let score: Double

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case isPrivate = "private"
        case owner
        case htmlURL = "html_url"
        case description
        case fork
        case url
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case homepage
        case size
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        case hasIssues = "has_issues"
        case hasProjects = "has_projects"
        case hasDownloads = "has_downloads"
        case hasWiki = "has_wiki"
        case hasPages = "has_pages"
        case hasDiscussions = "has_discussions"
        case forksCount = "forks_count"
        case mirrorURL = "mirror_url"
        case archived
        case disabled
        case openIssuesCount = "open_issues_count"
        case license
        case allowForking = "allow_forking"
        case isTemplate = "is_template"
        case webCommitSignoffRequired = "web_commit_signoff_required"
        case topics
        case visibility
        case forks
        case openIssues = "open_issues"
        case watchers
        case defaultBranch = "default_branch"
        case score
    }
}

struct Owner: Codable {
    let login: String
    let id: Int
    let nodeID: String
    let avatarURL: String
    let gravatarID: String
    let url: String
    let htmlURL: String
    let followersURL: String
    let followingURL: String
    let gistsURL: String
    let starredURL: String
    let subscriptionsURL: String
    let organizationsURL: String
    let reposURL: String
    let eventsURL: String
    let receivedEventsURL: String
    let type: OwnerType
    let userViewType: String?
    let siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case userViewType = "user_view_type"
        case siteAdmin = "site_admin"
    }
}

enum OwnerType: String, Codable {
    case user = "User"
    case organization = "Organization"
}

struct License: Codable {
    let key: String
    let name: String
    let spdxID: String
    let url: String?
    let nodeID: String

    enum CodingKeys: String, CodingKey {
        case key, name
        case spdxID = "spdx_id"
        case url
        case nodeID = "node_id"
    }
}

enum Visibility: String, Codable {
    case `public` = "public"
    case `private` = "private"
    case internalVisibility = "internal"
}
