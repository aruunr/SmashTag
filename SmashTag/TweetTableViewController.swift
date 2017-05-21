//
//  TweetTableViewController.swift
//  SmashTag
//
//  Created by Arun Ramaswamy on 5/16/17.
//  Copyright © 2017 Arun Ramaswamy. All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewController: UITableViewController {

    private var tweets = [Array<Tweet>]() {
        didSet{
        print(tweets)
        }
    }
    
    var searchTweet : String? {
        didSet{
        tweets.removeAll()
        tableView.reloadData()
        searchForTweets()
        title = searchTweet
        }
    }

    //return a Twitter request
    
    private func twitterRequest() -> Twitter.Request?{
        if let query = searchTweet, !query.isEmpty {
            return Twitter.Request(search: query, count: 100)
        }
        return nil
    }
    
    private var lastTwitterRequest : Twitter.Request?
    
    private func searchForTweets() {
        if let request = twitterRequest() {
            lastTwitterRequest = request
            request.fetchTweets {[weak self] newTweets in
                DispatchQueue.main.async {
                    if request == self?.lastTwitterRequest {
                        self?.tweets.insert(newTweets, at: 0)
                        self?.tableView.insertSections([0], with: .fade)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTweet = "#Apple"
    }
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return tweets.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Tweet", for: indexPath)
            let tweet = tweets[indexPath.section][indexPath.row]
            cell.textLabel?.text = tweet.text
            cell.detailTextLabel?.text = tweet.user.name
        return cell
    }
    

   

}
