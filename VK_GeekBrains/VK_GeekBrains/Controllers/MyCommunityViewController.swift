//
//  MyCommunityViewController.swift
//  VK_GeekBrains
//
//  Created by Станислав on 30.03.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class MyCommunityViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension MyCommunityViewController: UITableViewDelegate{
    
}
extension MyCommunityViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCommunityCell", for: indexPath)
        cell.textLabel?.text = "My Community"
        return cell
    }
}
