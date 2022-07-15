//
//  ImageModel.swift
//  iOSEngineerCodeCheck
//
//  Created by 中田伊織 on 2022/07/15.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit

class Image {
    
    //画像を取得する関数
    func getImage(for repo: Repository, success: @escaping(UIImage) -> Void, failure: @escaping(Error) -> Void) {
        let owner = repo.owner
        guard let imgURL = owner["avatar_url"] as? String else { return } //URLを取得する
        var request = URLRequest(url: URL(string: imgURL)!) //リクエストを作成する
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            //エラーがあればエラーを返す
            if let error = error  {
                failure(error)
                return
            }
            else {
                guard let data = data else { return }
                guard let img = UIImage(data: data) else {
                    return
                }
                DispatchQueue.main.async {
                    success(img)
                }
            }
        }
        task.resume()
    }
}
