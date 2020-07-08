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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            self.myCommunites.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        action.backgroundColor = .red
        action.image = UIImage(systemName: "trash.fill")
        
        return action
    }
    
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