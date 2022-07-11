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
    func getRepository(word: String?, repo: [[String: Any]], tableView: UITableView) {
        guard let word = word else { return }
        let url = URL(string: "https://api.github.com/search/repositories?q=\(word)") //URLを生成
        guard let url = url else { return }
        let request = URLRequest(url: url)  //Requestを生成
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in  //非同期で通信を行う
            guard let data = data else { return }
            do {
                guard let objectOptional = try? JSONSerialization.jsonObject(with: data, options: []),
                      let object = objectOptional as? [[String: Any]] else { return }    // DataをJsonに変換
                
                var repos = [Repository]()
                for r in object {
                    let repository = Repository(attributes: r)
                    repos.append(repository)
                }
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
                
            } catch let error {
                print(error)
            }
        }
        task.resume()
    }
}
