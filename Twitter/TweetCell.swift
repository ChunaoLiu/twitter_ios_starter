//
//  TweetCell.swift
//  Twitter
//
//  Created by 刘淳傲 on 2/13/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    
    @IBOutlet weak var tweetImage: UIImageView!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var tweetName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var favorited:Bool = false
    var tweetID:Int = -1

    @IBOutlet weak var favButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if (toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetID: tweetID, success: {
                self.setFavorite(true)
            }, failure: { (Error) in
                print("We Failed to heart ya...")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetID: tweetID, success: {
                self.setFavorite(false)
            }, failure: { (Error) in
                print("We CANNOT stop LOVING YA!\nBecause:\(Error)")
            })
        }
    }
    @IBAction func rewteet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetID: tweetID, success: {
            self.setRetweeted(true)
        }, failure: { (Error) in	
            print("Error code:\(Error)")
        })
    }
    
    func setFavorite(_ isFavorited:Bool){
        favorited = isFavorited
        if (favorited){
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else{
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweeted(_ isReTweeted:Bool){
        if (isReTweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }
        else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
