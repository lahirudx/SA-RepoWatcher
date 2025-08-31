//
//  Repository.swift
//  RepoWatcher
//
//  Created by Lahiru Amarasooriya on 2025-08-30.
//

import Foundation

struct Repository {
    let name: String
    let owner: Owner
    let hasIssues: Bool
    let forks: Int
    let watchers: Int
    let openIssues: Int
    let pushedAt: String
    var avatarData: Data
    
    
    
}

extension Repository {
    
    struct CodingData: Decodable {
        let name: String
        let owner: Owner
        let hasIssues: Bool
        let forks: Int
        let watchers: Int
        let openIssues: Int
        let pushedAt: String
        
        var repo: Repository {
            .init(name: name, owner: owner, hasIssues: hasIssues, forks: forks, watchers: watchers, openIssues: openIssues, pushedAt: pushedAt, avatarData: Data())
        }
    }
}

struct Owner: Decodable {
    let avatarUrl: String
}
