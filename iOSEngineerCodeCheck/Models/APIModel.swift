//
//  APIModel.swift
//  iOSEngineerCodeCheck
//
//  Created by 中田伊織 on 2022/07/11.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

enum APIError: Error, CustomStringConvertible {
    case unknown
    case urlError
    case responseError
    
    var description: String {
        switch self {
        case .unknown:
            return "unknown error"
        case .urlError:
            return "URL error"
        case .responseError:
            return "response error"
        }
    }
}

class API {
    
    func getData(for word: String, success: @escaping([Repository]) -> Void, failure: @escaping(Error) -> Void) {
        let requestURL = URL(string: "https://api.github.com/search/repositories?q=\(word)")
        guard let requestURL = requestURL else {
            failure(APIError.urlError)
            return
        }
        var request = URLRequest(url: requestURL) //リクエストを作成
        request.httpMethod = "GET"
        
        //タスクを作成
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //エラーが存在すればエラーを返す
            if let error = error {
                DispatchQueue.main.async {
                    failure(error)
                }
                return
            }
            else {
                guard let data = data else {
                    //dataがなければエラーを返す
                    DispatchQueue.main.async {
                        failure(APIError.unknown)
                    }
                    return
                }
                
                guard let jsonOptional = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    //レスポンスエラー
                    DispatchQueue.main.async {
                        failure(APIError.responseError)
                    }
                    return
                }
                
                guard let json = jsonOptional["items"] as? [[String: Any]] else {
                    //型変換に失敗したらエラーを返す
                    DispatchQueue.main.async {
                        failure(APIError.unknown)
                    }
                    return
                }

                var repos = [Repository]() //Repositoryを検索した際に出る候補
                //候補を追加
                for j in json {
                    let repo = Repository(attributes: j)
                    repos.append(repo)
                }
                DispatchQueue.main.async {
                    success(repos)
                }
            }

        }
        //タスクを実行
        task.resume()

    }
}
