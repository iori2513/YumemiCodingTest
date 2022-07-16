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
    
    @IBOutlet weak var TtlLbl: UILabel!
    
    @IBOutlet weak var LangLbl: UILabel!
    
    @IBOutlet weak var StrsLbl: UILabel!
    @IBOutlet weak var WchsLbl: UILabel!
    @IBOutlet weak var FrksLbl: UILabel!
    @IBOutlet weak var IsssLbl: UILabel!
    
    var vc1: SearchRepositoryVC!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetting()
    }
    
    func viewSetting() {
        let repo = vc1.repos[vc1.idx]
        
        //Labelに挿入するテキストを設定
        TtlLbl.text = repo.name
        LangLbl.text = "Written in \(repo.language)"
        StrsLbl.text = "\(repo.stargazersCount) stars"
        WchsLbl.text = "\(repo.watchersCount) watchers"
        FrksLbl.text = "\(repo.forksCount) forks"
        IsssLbl.text = "\(repo.openIssuesCount) open issues"
        
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
