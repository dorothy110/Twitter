//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Dorothy on 2022/9/29.
//  Copyright © 2022 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileimageview: UIImageView!
    
    @IBOutlet weak var usernamelabel: UILabel!
    
    @IBOutlet weak var tweetcontent: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
