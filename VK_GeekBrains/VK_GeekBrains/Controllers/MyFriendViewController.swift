//
//  MyFriendViewController.swift
//  VK_GeekBrains
//
//  Created by Станислав on 30.03.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class MyFriendViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var friends = Users()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FriendsToPhotoSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! PhotoToFriendViewController
                controller.photosToFriend = friends.list[indexPath.row].image
                controller.title = friends.list[indexPath.row].name
            }
        }
    }
}
extension MyFriendViewController: UITableViewDelegate{
    
 
}
extension MyFriendViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.list.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath) as! FriendTableViewCell
        let friend = friends.list[indexPath.row]
        cell.avatarImageView.image = UIImage(named: friend.avatar)
        cell.nameLabel.text = friend.name
        return cell
    } 
}
