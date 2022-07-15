//
//  APIModel.swift
//  iOSEngineerCodeCheck
//
//  Created by 中田伊織 on 2022/07/11.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit


class API {
    
    func getData(for word: String, success: @escaping([Repository]) -> Void, failure: @escaping(Error) -> Void) {
        let requestURL = URL(string: "https://api.github.com/search/repositories?q=\(word)")
        guard let requestURL = requestURL else {
            return
        }
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    failure(error)
                }
                return
            }
            guard let data = data else { return }
            guard let jsonOptional = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else { return }
            guard let json = jsonOptional["items"] as? [[String: Any]] else { return }

            var repos = [Repository]()
            for j in json {
                let repo = Repository(attributes: j)
                repos.append(repo)
            }
            DispatchQueue.main.async {
                success(repos)
            }

            }
        task.resume()

    }
}
