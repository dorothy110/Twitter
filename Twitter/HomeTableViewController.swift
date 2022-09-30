import UIKit
class HomeTableViewController: UITableViewController {
    
    var tweetarry = [NSDictionary]()
    var numberoftweet:Int!
    
    let myrefreshcontrol = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadtweet()
        
        myrefreshcontrol.addTarget(self, action: #selector(loadtweet), for: .valueChanged)
        tableView.refreshControl = myrefreshcontrol
    }
    
    @objc func loadtweet(){
        
        numberoftweet = 20
        let myurl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myparam = ["count":numberoftweet]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myurl, parameters: myparam, success: { (tweets:[NSDictionary]) in
            self.tweetarry.removeAll()
            for tweet in tweets{
                self.tweetarry.append(tweet)
            }
            self.tableView.reloadData()
            self.myrefreshcontrol.endRefreshing()
        }, failure: { (Error) in
            print("Counld not retreive tweets! oh no!")
            print(Error.localizedDescription)
        })
    }
    
    func loadmoretweets(){
        let myurl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberoftweet = numberoftweet + 20
        let myparam = ["count":numberoftweet]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myurl, parameters: myparam, success: { (tweets:[NSDictionary]) in
            self.tweetarry.removeAll()
            for tweet in tweets{
                self.tweetarry.append(tweet)
            }
            self.tableView.reloadData()
 
        }, failure: { (Error) in
            print("Counld not retreive tweets! oh no!")
            print(Error.localizedDescription)
        })
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetarry.count{
            loadmoretweets()
        }
    }
    
    
    
    
    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey:"userloggedin")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetcell", for: indexPath) as! TweetCellTableViewCell
        let user = tweetarry[indexPath.row]["user"] as! NSDictionary
        
        cell.usernamelabel.text = user["name"] as? String
        cell.tweetcontent.text = tweetarry[indexPath.row]["text"] as? String
        
        let imageurl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageurl!)
        if let imageData = data {
            cell.profileimageview.image = UIImage(data:imageData)
        }
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetarry.count
    }

   


}
