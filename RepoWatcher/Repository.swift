//
//  Repository.swift
//  RepoWatcher
//
//  Created by Lahiru Amarasooriya on 2025-08-30.
//

import Foundation

struct Repository: Decodable {
    let name: String
    let owner: Owner
    let hasIssues: Bool
    let forks: Int
    let watchers: Int
    let openIssues: Int
    let pushedAt: String
    
    static let placeholder = Repository(name: "Your Repo", owner: Owner(avatarUrl: ""), hasIssues: true, forks: 99, watchers: 19, openIssues: 23, pushedAt: "2023-08-27T12:56:23Z")
    
}

struct Owner: Decodable {
    let avatarUrl: String
}
