//
//  AllCommunityViewController.swift
//  VK_GeekBrains
//
//  Created by Станислав on 30.03.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class AllCommunityViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension AllCommunityViewController: UITableViewDelegate{
    
}
extension AllCommunityViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allCommunityCell", for: indexPath)
        cell.textLabel?.text = "Comunity"
        return cell
    }
}
