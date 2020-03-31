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
    
    var myCommunites = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addCommunity(segue: UIStoryboardSegue){
        if segue.identifier == "addCommunitySegue" {
            let allCommunityController = segue.source as! AllCommunityViewController
            
            if let indexPath = allCommunityController.tableView.indexPathForSelectedRow {
                let community = allCommunityController.communites[indexPath.row]
                if !myCommunites.contains(community){
                    myCommunites.append(community)
                    tableView.reloadData()
                }
            }
        }
    }
}
extension MyCommunityViewController: UITableViewDelegate{
    
}
extension MyCommunityViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCommunites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCommunityCell", for: indexPath) as! MyCommunityTableViewCell
        cell.imageCommunityView.image = UIImage(named: myCommunites[indexPath.row].avatar)
        cell.nameCommunitylabel.text = myCommunites[indexPath.row].name
        return cell
    }
}
