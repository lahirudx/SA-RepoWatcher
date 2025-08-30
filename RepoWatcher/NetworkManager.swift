//
//  NetworkManager.swift
//  RepoWatcher
//
//  Created by Lahiru Amarasooriya on 2025-08-30.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let decoder = JSONDecoder()
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        
    }
    
    func getRepo(atUrl urlString: String) async throws -> Repository {
         guard let url = URL(string: urlString) else {
             throw NetworkError.invalidRepoURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            return try decoder.decode(Repository.self, from: data)
        } catch {
            throw NetworkError.invalidRepoData
        }
        
    }
    
}

enum NetworkError: Error {
    case invalidRepoURL
    case invalidResponse
    case invalidRepoData
}

enum RepoURL {
    static let swiftNews = "https://api.github.com/repos/sallen0400/swift-news"
    static let publish = "https://api.github.com/repos/johnsundell/publish"
    static let google = "https://api.github.com/repos/g00gle/GoogleSignIn-iOS"
    
}
