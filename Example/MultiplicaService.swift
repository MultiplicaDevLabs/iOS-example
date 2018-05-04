//
//  MultiplicaService.swift
//  Example
//
//  Created by Daniel Cabello on 3/23/18.
//  Copyright © 2018 Daniel Cabello. All rights reserved.
//

import Foundation
import Siesta

class MultiplicaService {
    let api = Service(baseURL: "https://api.github.com/",
                      standardTransformers: [.text, .image])
    
    init() {
        let jsonDecoder = JSONDecoder()
        api.configureTransformer("/users/*/repos") {
            try jsonDecoder.decode([Repository].self, from: $0.content)
        }
        api.configureTransformer("/search/repositories") {
            try jsonDecoder.decode(SearchResult.self, from: $0.content)
        }
    }
    
    func repos(_ username: String) -> Resource {
        return api
            .resource("/users")
            .child(username.lowercased())
            .child("/repos")
    }
    func search( term: String) -> Resource {
        return api
            .resource("/search")
            .child("/repositories")
            .withParam("q", term)
    }
    
}

struct SearchResult: Codable {
    let items: [Repository]
}

struct Repository: Codable {
    let url: String
    let name: String
    let starCount: Int?
    let owner: User
    let description: String?
    let homepage: String?
    let languagesURL: String?
    let contributorsURL: String?
    let language: String?
    let size: Int?	
    enum CodingKeys: String, CodingKey {
        case url
        case name
        case starCount       = "stargazers_count"
        case description
        case homepage
        case languagesURL    = "languages_url"
        case contributorsURL = "contributors_url"
        case owner
        case language
        case size
    }
}

struct User: Codable {
    let login, repositoriesURL, avatarURL: String
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case login
        case name
        case repositoriesURL = "repos_url"
        case avatarURL       = "avatar_url"
    }
}
