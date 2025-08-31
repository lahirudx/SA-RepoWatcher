//
//  MockData.swift
//  RepoWatcher
//
//  Created by Lahiru Amarasooriya on 2025-08-31.
//

import Foundation

struct MockData {
    static let repoOne = Repository(
        name: "Repository One",
        owner: Owner(avatarUrl: ""),
        hasIssues: true,
        forks: 99, watchers: 19,
        openIssues: 23,
        pushedAt: "2025-04-27T12:56:23Z",
        avatarData:Data()
    )
    
    static let repoTwo = Repository(
        name: "Repository Two",
        owner: Owner(avatarUrl: ""),
        hasIssues: false,
        forks: 134, watchers: 976,
        openIssues: 120,
        pushedAt: "2025-08-27T12:56:23Z",
        avatarData:Data()
    )
}
