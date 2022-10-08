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
    
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButtion: UIButton!
    
    
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorite = !favorited
        if(toBeFavorite){
            TwitterAPICaller.client?.favoriteTweet(tweetID: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("favorite did not succeed: \(error)")
            })
        }else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetID: tweetId, success: {self.setFavorite(false)}, failure: {(error) in
                print("favorite did not succeed: \(error)")
            })
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetID: tweetId, success: {self.setRetweeted(true)}, failure: {(error) in print("error is retweeting:\(error)")
        })
    }
    var favorited:Bool = false
    var tweetId: Int = -1
    
    func setRetweeted(_ isRetweeted:Bool){
        if(isRetweeted){
            retweetButtion.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButtion.isEnabled = false
        }else {
            retweetButtion.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButtion.isEnabled = true
        }
        
    }
    
    func setFavorite(_ isFavorited: Bool){
        favorited = isFavorited
        if(favorited) {
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
            
        }
        else {
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
