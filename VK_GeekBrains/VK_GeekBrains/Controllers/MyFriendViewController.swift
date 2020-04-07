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
    private var lettersControl = LettersControl()
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {
            return false
        }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    var friends = Users().list
    var firstLettersOfFriends = [Character]()
    
    var filtredFriends = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setFilterFriends()
        
        setSearchController()
        getFirstLettersToFtiend()
        setLettersControl()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FriendsToPhotoSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! PhotoToFriendViewController
                controller.photosToFriend = friends[indexPath.row].image
                controller.title = friends[indexPath.row].name
            }
        }
    }
    func setFilterFriends() {
        friends = friends.sorted(by: { (firstUser, secondUser) -> Bool in
            firstUser.name < secondUser.name
        })
        
    }
    private func setSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    private func getFirstLettersToFtiend() {
        let firstLetters = friends.map{ $0.name.first!}
        for letter in firstLetters {
            if !firstLettersOfFriends.contains(letter){
                firstLettersOfFriends.append(letter)
            }
        }
        firstLettersOfFriends = firstLettersOfFriends.sorted()
    }
    
    private func setLettersControl(){
        
        view.addSubview(lettersControl)
        lettersControl.translatesAutoresizingMaskIntoConstraints = false
        lettersControl.arrChar = firstLettersOfFriends
        lettersControl.backgroundColor = .clear
        lettersControl.addTarget(self, action: #selector(scrollToSelectedLetter), for: [.touchUpInside])
        
        lettersControl.heightAnchor.constraint(equalToConstant: CGFloat(15*firstLettersOfFriends.count)).isActive = true
        lettersControl.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        lettersControl.widthAnchor.constraint(equalToConstant: 20).isActive = true
        lettersControl.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    @objc func scrollToSelectedLetter(){
        let selectLetter = lettersControl.selectedLetter
        for (index,friend) in friends.enumerated(){
            if friend.name.first == selectLetter{
                tableView.scrollToRow(at: IndexPath(row: index, section: 0), at: .top, animated: true)
                break
            }
        }
    }
    
}
extension MyFriendViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filterFriendForSearchText(searchController.searchBar.text!)
    }
    
    private func filterFriendForSearchText(_ searchText: String){
        if !searchText.isEmpty {
            friends = Users().list.filter({ (friend: User) -> Bool in
                return friend.name.lowercased().contains(searchText.lowercased())
            })
            lettersControl.isHidden = true
        } else {
            
            lettersControl.isHidden = false
        }
        setFilterFriends()
        tableView.reloadData()
    }
}

extension MyFriendViewController: UITableViewDelegate{
    
 
}

extension MyFriendViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isFiltering {
//            return filtredFriends.count
//        }
        return friends.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath) as! FriendTableViewCell
//        var friend: User
//        if isFiltering {
//            friend = filtredFriends[indexPath.row]
//        } else {
//            friend = friends[indexPath.row]
//        }
        let friend = friends[indexPath.row]
        cell.avatarImageView.image = UIImage(named: friend.avatar)
        cell.nameLabel.text = friend.name
        return cell
    } 
}
