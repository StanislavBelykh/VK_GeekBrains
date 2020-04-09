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
    var friendsDict = [Character:[User]]()
    
    var firstLettersOfFriends:[Character]{
        get{
            return [Character](friendsDict.keys).sorted()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        getFilterFriendsForSection()
        setSearchController()
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
    func getFilterFriendsForSection(){
        for friend in friends {
            if friendsDict.keys.contains(friend.name.first ?? Character("")){
                friendsDict[friend.name.first!]?.append(friend)
            } else {
                friendsDict[friend.name.first!] = [friend]
            }
        }
    }
    private func setSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
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
        for indexSextion in 0..<firstLettersOfFriends.count{
            if selectLetter == firstLettersOfFriends[indexSextion]{
                tableView.scrollToRow(at: IndexPath(row: 0, section: indexSextion), at: .top, animated: true)
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
        friends = friends.sorted{ $0.name < $1.name }
        tableView.reloadData()
    }
}

extension MyFriendViewController: UITableViewDelegate{
    
 
}

extension MyFriendViewController: UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if !searchBarIsEmpty {
            return 1
        }
        return firstLettersOfFriends.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if !searchBarIsEmpty {
            let label = UILabel()
            label.text = "Результаты поиска"
            label.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            return label
        }
        let footer = FooterForTable()
        footer.label.text = String(firstLettersOfFriends[section])
        return footer
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !searchBarIsEmpty {
            return friends.count
        }
        let key = firstLettersOfFriends[section]
        if let friendsForKey = friendsDict[key]{
            return friendsForKey.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath) as! FriendTableViewCell
        if !searchBarIsEmpty{
            let friend = friends[indexPath.row]
            cell.avatarImageView.image = UIImage(named: friend.avatar)
            cell.nameLabel.text = friend.name
            return cell
        }
        let key = firstLettersOfFriends[indexPath.section]
        let friendsForKey = friendsDict[key]
        let friend = friendsForKey?[indexPath.row]
    
        cell.avatarImageView.image = UIImage(named: friend?.avatar ?? "logo")
        cell.nameLabel.text = friend?.name
        return cell
    } 
}
