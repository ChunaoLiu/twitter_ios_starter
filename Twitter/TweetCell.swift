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

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
