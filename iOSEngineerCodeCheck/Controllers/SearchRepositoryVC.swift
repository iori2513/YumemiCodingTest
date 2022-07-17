//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchRepositoryVC: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var SchBr: UISearchBar!
    
    var repos = [Repository]() //検索したRepositoryを保存する
    var idx: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SchBr.placeholder = "GitHubのリポジトリを検索できるよー"
        SchBr.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var word = searchBar.text
        word?.removeAll(where: {$0 == " "}) //検索欄の空白を取り除く
        let api = API()
        guard let word = word else { return }
        if word.isEmpty {
            //検索欄が空白のみならアラート表示
            alert()
        } else {
            //Repositoryの検索をかける
            api.getData(for: word, success: { [weak self] (repos) in //循環参照を防ぐ
                guard let self = self else { return }
                self.repos = repos
                self.tableView.reloadData()
                return
            }, failure: {(error) in
                print(error)
                return
            })
        }
    }
    
    private func alert() {
        let alert = UIAlertController(title: "エラー", message: "文字を入力してください", preferredStyle: .alert)
        let button = UIAlertAction(title: "OK", style: .default) { [weak self] (action) in
            guard let self = self else { return }
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(button)
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Detail"{
            let dtl = segue.destination as! RepositoryDetailVC
            dtl.vc1 = self
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //contentConfigurationを用いてレイアウトを整える
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        let rp = repos[indexPath.row]
        
        // cellの内容
        content.text = rp.name
        content.secondaryText = rp.language
        cell.contentConfiguration = content
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        idx = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
        
    }
    
}
