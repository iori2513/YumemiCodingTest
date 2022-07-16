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
    
    var repos = [Repository]()
    var idx: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SchBr.placeholder = "GitHubのリポジトリを検索できるよー"
        SchBr.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let word = searchBar.text
        
        if let word = word {
            let api = API()
            api.getData(for: word, success: { (repos) in
                self.repos = repos
                self.tableView.reloadData()
                return
            }, failure: {(error) in
                print(error)
                return
            })
            
        }
        else { return }
        
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
