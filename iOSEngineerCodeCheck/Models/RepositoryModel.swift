//
//  RepositoryModel.swift
//  iOSEngineerCodeCheck
//
//  Created by 中田伊織 on 2022/07/11.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

class Repository {
    let name: String
    let language: String
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let owner: [String: Any]
    
    init(attributes: [String: Any]) {
        name = attributes["full_name"] as! String
        language = attributes["language"] as! String
        stargazersCount = attributes["stargazers_count"] as? Int ?? 0
        watchersCount = attributes["wachers_count"] as? Int ?? 0
        forksCount = attributes["forks_count"] as? Int ?? 0
        openIssuesCount = attributes["open_issues_count"] as? Int ?? 0
        owner = attributes["owner"] as? [String: Any] ?? [:]
        
        
    }
    
}
