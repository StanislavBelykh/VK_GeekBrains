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
    
    var searchController: UISearchController!
    
    var communites = Groups().list
    var filtredCommunites = [Group]()
    var shouldShowSearchResults = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
    }
    
}
extension AllCommunityViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        
        if let text = searchText?.lowercased(){
            guard !text.isEmpty else {
               return filtredCommunites = communites
            }
            filtredCommunites = communites.filter({ (community) -> Bool in
                community.name.lowercased().contains(text)
            })
        } else {
            filtredCommunites = communites
        }
        tableView.reloadData()
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    
}
extension AllCommunityViewController: UITableViewDelegate{
    
}
extension AllCommunityViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return filtredCommunites.count
        } else {
            return communites.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allCommunityCell", for: indexPath) as! AllCommunityTableViewCell
        if shouldShowSearchResults {
            cell.imageCommunityView.image = UIImage(named: filtredCommunites[indexPath.row].avatar)
            cell.nameCommunityLabel.text = filtredCommunites[indexPath.row].name
        }else {
            cell.imageCommunityView.image = UIImage(named: communites[indexPath.row].avatar)
            cell.nameCommunityLabel.text = communites[indexPath.row].name
        }
        return cell
    }
}
