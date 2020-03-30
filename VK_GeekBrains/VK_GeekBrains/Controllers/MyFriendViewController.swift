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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension MyFriendViewController: UITableViewDelegate{
 
}
extension MyFriendViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath)
        cell.textLabel?.text = "Friend"
        return cell
    } 
}
