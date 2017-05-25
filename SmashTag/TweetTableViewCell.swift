//
//  TweetTableViewCell.swift
//  SmashTag
//
//  Created by Arun Ramaswamy on 5/21/17.
//  Copyright © 2017 Arun Ramaswamy. All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var tweetCreatedDate: UILabel!
    @IBOutlet weak var tweeterName: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    var tweet : Twitter.Tweet?{
        didSet{
            UpdateUI()
        }
    }
    
    private func UpdateUI(){
        tweeterName?.text = tweet?.user.description
        tweetContent?.text = tweet?.text

        if let imageURL = tweet?.user.profileImageURL {
        
            if let imageData = try? Data(contentsOf: imageURL){
                tweetImageView?.image = UIImage(data: imageData)
            }
        
        }
        
        if let created = tweet?.created{
            let formatter = DateFormatter()
            tweetCreatedDate?.text = formatter.string(from: created)
        }
    }
    
}
