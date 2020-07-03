//
//  AllCommunityViewController.swift
//  VK_GeekBrains
//
//  Created by Станислав on 30.03.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class AllCommunityViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private var searchController: UISearchController!
    private var searchText = ""
    
    private var imageService: ImageService?
    private let networkService = NetworkingService()
    private var isSearching = false
    
    var communites = [Community]()
    var didSelectIndexCommunity: Int?
      
    override func viewDidLoad() {
        super.viewDidLoad()
        imageService = ImageService(container: tableView)
        configureSearchController()
    }
}

//MARK: - Search Bar
extension AllCommunityViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty, isSearching else { return }

        isSearching.toggle()
        networkService.getSearchCommunity(text: searchText, onComplete: { [weak self] (communites) in
            self?.communites = communites
            self?.tableView.reloadData()
            self?.isSearching.toggle()
        }, onError: { [unowned self] (error) in
            self.isSearching.toggle()
            print(error)
        })
    }
    
    func searchBarTextDidBeginEditing( _  searchBar : UISearchBar) {
        communites.removeAll()
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked( _  searchBar : UISearchBar) {
        communites.removeAll()
        tableView.reloadData()
    }
    
    private func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
    }
}
//MARK: - UITableViewDelegate
extension AllCommunityViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectIndexCommunity = indexPath.row
    }
}
//MARK: - UITableViewDataSource
extension AllCommunityViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "allCommunityCell", for: indexPath) as! AllCommunityTableViewCell
        
        let community = communites[indexPath.row]
        let imageCommunity = imageService?.photo(atIndexpath: indexPath, byUrl: community.avatarURL)
        
        cell.configure(imageCommunity: imageCommunity, nameCommunity: community.name)

        return cell
    }
}
