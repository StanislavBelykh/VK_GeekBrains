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
    
    let networkService = NetworkingService()
    var isSearching = false
    
    var communites = [Community]()
      
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
    }
    
}
extension AllCommunityViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            self.communites.removeAll()
            self.tableView.reloadData()
            return
        }
         
        if !isSearching {
            isSearching.toggle()
            networkService.getSearchCommunity(text: searchText, onComplete: { [weak self] (communites) in
                self?.communites = communites
                self?.tableView.reloadData()
                self?.isSearching.toggle()
            }) { (error) in
                self.isSearching.toggle()
                print(error)
            }
        }
    }
    
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        shouldShowSearchResults = true
//        tableView.reloadData()
//    }
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        shouldShowSearchResults = false
//        tableView.reloadData()
//    }
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
        return communites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allCommunityCell", for: indexPath) as! AllCommunityTableViewCell
        
        let community = communites[indexPath.row]
        
        cell.nameCommunityLabel.text = community.name
        community.getAvatarImage(for: &cell.imageCommunityView)
        return cell
    }
}
