//
//  homeTableViewController.swift
//  Twitter
//
//  Created by 刘淳傲 on 2/13/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class homeTableViewController: UITableViewController {
    
    var tweetArray = [NSDictionary]()
    var numberOfTweet: Int!
    
    let myRefreshControl = UIRefreshControl()

    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.setValue(false, forKey: "userLoggedIn")
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweet()
        
        myRefreshControl.addTarget(self, action: #selector(loadTweet), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        self.loadTweet()
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 150
    }
    
    @objc func loadTweet(){
        numberOfTweet = 20
        let URL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let Params = ["count": numberOfTweet]
        
        
        TwitterAPICaller.client?.getDictionariesRequest(url: URL, parameters: Params as [String : Any], success: { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
            self.myRefreshControl.endRefreshing()
            
        }, failure: { (Error) in
            print("We Failed...")
        })
    }
    
    func loadMoreTweets(){
        let URL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        
        numberOfTweet += 20
        let Params = ["count": numberOfTweet]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: URL, parameters: Params as [String : Any], success: { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
            self.myRefreshControl.endRefreshing()
            
        }, failure: { (Error) in
            print("We Failed...")
        })
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        cell.tweetName.text = user["name"] as? String
        cell.tweetContent.text = tweetArray[indexPath.row]["text"] as? String
        
        let imageURL = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageURL!)
        
        if let imageData = data {
            cell.tweetImage.image = UIImage(data: imageData)
        }
        
        cell.setFavorite(tweetArray[indexPath.row]["favorited"] as! Bool)
        cell.tweetID = tweetArray[indexPath.row]["id"] as! Int
        cell.setRetweeted(tweetArray[indexPath.row]["retweeted"] as! Bool)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count{
            loadMoreTweets()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }
  
 }
