//
//  TopEntriesVC.swift
//  RedditTaras
//
//  Created by 123 on 02.06.17.
//  Copyright © 2017 taras team. All rights reserved.
//

import UIKit

class TopEntriesVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    typealias DownloadComplete = () -> ()
    
    let urlStr = "https://www.reddit.com/top.json?limit=50"
    
    var entries = [Entry]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        downloadEntries() {
            self.tableView.reloadData()
        }
    }
    
    
    func downloadEntries(completed: @escaping DownloadComplete) {
        let session = URLSession.shared
        
        if let url = URL(string: urlStr) {
            let task = session.dataTask(with: url) { (data, response, error) -> Void in
                
                if error != nil {
                    print(error!)
                } else {
                    if let data = data {
                        print(data)
                        
                        if let jsonObj = try? JSONSerialization.jsonObject(with: data, options:[]) as? Dictionary<String, AnyObject> {
                            
                            if let data = jsonObj!["data"] as? Dictionary<String, AnyObject> {
                                
                                if let childrens = data["children"] as? [Dictionary<String, AnyObject>] {
                                    for children in childrens {
                                        if let data = children["data"] as? Dictionary<String, AnyObject> {
                                            let entry = Entry.init(entryInfo: data)
                                            self.entries.append(entry)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                DispatchQueue.main.async(execute: {
                    completed()
                })
            }
            task.resume()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        // Dispose of any resources that can be recreated.
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath) as?EntryViewCell {
        cell.configCell(entry: entries[indexPath.row])
        return cell
        } else {
            return EntryViewCell()
        }
    }
}

