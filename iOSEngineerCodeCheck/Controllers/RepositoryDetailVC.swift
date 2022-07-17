//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class RepositoryDetailVC: UIViewController {
    
    @IBOutlet weak var ImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var langLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var issueLabel: UILabel!
    var vc1: SearchRepositoryVC!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
    }
    
    private func viewSetting() {
        let repo = vc1.repos[vc1.idx]
        
        //Labelに挿入するテキストを設定
        titleLabel.text = repo.name
        langLabel.text = "Written in \(repo.language)"
        starsLabel.text = "\(repo.stargazersCount) stars"
        watchersLabel.text = "\(repo.watchersCount) watchers"
        forksLabel.text = "\(repo.forksCount) forks"
        issueLabel.text = "\(repo.openIssuesCount) open issues"
        
        //画像を取得し、画面に表示する
        let image = Image()
        image.getImage(for: repo, success: {[weak self] (img) in //循環参照を防ぐ
            guard let self = self else { return }
            self.ImgView.image = img
            return
        }, failure: {(error) in
            print(error)
            return
        })
    }
}
