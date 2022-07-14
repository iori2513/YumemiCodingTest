//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var SchBr: UISearchBar!
    
    var repos = [Repository]()
    
    var task: URLSessionTask?
    var word: String?
    var url: String!
    var idx: Int!
    
    let api = API()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        api.getData(success: {(repos) in
//            self.repos.append(contentsOf: repos)
//        }){(error) in
//            print(0)
//        }
        SchBr.text = "GitHubのリポジトリを検索できるよー"
        SchBr.delegate = self
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // ↓こうすれば初期のテキストを消せる
        searchBar.text = ""
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        word = searchBar.text
        
        if let word = word {
            
//            let result = api.getRepository(word: word, tableView: self.tableView)
//            repo = result.0
//            task = result.1
//            print(repo)
            api.getData(for: word, success: { (repos) in
                self.repos = repos
                self.tableView.reloadData()
                print(self.repos)
                return
            }, failure: {(error) in
                print(1)
                return
            })
            
            
            
//            url = "https://api.github.com/search/repositories?q=\(word!)"
//            task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, res, err) in
//                if let obj = try! JSONSerialization.jsonObject(with: data!) as? [String: Any] {
//                    if let items = obj["items"] as? [[String: Any]] {
//                    self.repo = items
//                        DispatchQueue.main.async {
//                            self.tableView.reloadData()
//                        }
//                    }
//                }
//            }
//        // これ呼ばなきゃリストが更新されません
//        task?.resume()
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
        }
        else { return }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Detail"{
            let dtl = segue.destination as! ViewController2
            dtl.vc1 = self
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let rp = repos[indexPath.row]
        cell.textLabel?.text = rp.name
        cell.detailTextLabel?.text = rp.language
        cell.tag = indexPath.row
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 画面遷移時に呼ばれる
        idx = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)
        
    }
    
}
