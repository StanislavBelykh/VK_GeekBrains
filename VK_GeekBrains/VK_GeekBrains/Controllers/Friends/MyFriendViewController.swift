//
//  MyFriendViewController.swift
//  VK_GeekBrains
//
//  Created by Станислав on 30.03.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit
import RealmSwift

class MyFriendViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var lettersControl: LettersControl?
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else {
            return false
        }
        return text.isEmpty
    }
    var imageService: ImageService?
    let networkService = NetworkingService()
    let realmManager = RealmManager()
    
    var token: NotificationToken?
    
    var data = [Friend]()
    var friends: Results<Friend>? //[Friend]()
    var friendsDict = [Character:[Friend]]()
    
    var firstLetters: [Character] {
        get {
            friendsDict.keys.sorted()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        realmManager.updateFriends()
        pairTableAndRealm()

        imageService = ImageService(container: tableView)
        setSearchController()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func pairTableAndRealm() {
        guard let realm = try? Realm() else { return }
        friends = realm.objects(Friend.self)
        token = friends?.observe { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                self?.setFriends()
            case .update(_, _, _ , _):
                self?.setFriends()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FriendsToPhotoSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! PhotoToFriendViewController
                let users = friendsDict[firstLetters[indexPath.section]]
                guard let user = users?[indexPath.row] else { return }
                
                controller.userID = user.id
                controller.title = user.firstName + " " + user.lastName
            }
        }
    }
    private func setFriends(){
        guard let friends = self.friends else { return }
        let tmpFriends = friends.filter{ !$0.lastName.isEmpty }
        self.data = Array(tmpFriends)
        self.friendsDict = self.getSortedUsers(searchText: nil, list: Array(tmpFriends))
        self.tableView.reloadData()
        self.setLettersControl()
    }
    private func getSortedUsers(searchText: String? , list: [Friend]) -> [Character:[Friend]]{
        var tempUsers: [Friend]
        if let text = searchText?.lowercased(), searchText != "" {
            tempUsers = list.filter{ $0.lastName.lowercased().contains(text) || $0.firstName.lowercased().contains(text) }
        } else {
            tempUsers = list
        }
        let sortedUsers = Dictionary.init(grouping: tempUsers) { $0.lastName.lowercased().first ?? "#" }
            .mapValues{ $0.sorted{ $0.lastName.lowercased() < $1.lastName.lowercased() } }
        return sortedUsers
    }
    
    private func setSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    private func setLettersControl(){
        lettersControl = LettersControl()
        guard let lettersControl = lettersControl else {
            return
        }
        view.addSubview(lettersControl)
       
        lettersControl.translatesAutoresizingMaskIntoConstraints = false
        lettersControl.arrChar = friendsDict.keys.sorted()
        lettersControl.backgroundColor = .clear
        lettersControl.addTarget(self, action: #selector(scrollToSelectedLetter), for: [.touchUpInside])
        
        NSLayoutConstraint.activate([
            lettersControl.heightAnchor.constraint(equalToConstant: CGFloat(15*lettersControl.arrChar.count)),
            lettersControl.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            lettersControl.widthAnchor.constraint(equalToConstant: 20),
            lettersControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
    
    @objc func scrollToSelectedLetter(){
        guard let lettersControl = lettersControl else {
            return
        }
        let selectLetter = lettersControl.selectedLetter
        for indexSextion in 0..<firstLetters.count{
            if selectLetter == firstLetters[indexSextion]{
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
        friendsDict = self.getSortedUsers(searchText: searchText, list: data)
        
        if searchText == "" {
            lettersControl?.isHidden = false
        }else{
            lettersControl?.isHidden = true
        }
        tableView.reloadData()
    }
}

extension MyFriendViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
        cell.transform = scale
        cell.alpha = 0.5

        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: [.curveEaseInOut],
                       animations: {
                        cell.transform = .identity
                        cell.alpha = 1
        })
    }  
}

extension MyFriendViewController: UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return friendsDict.keys.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let footer = FooterForTable()
        footer.label.text = String(firstLetters[section].uppercased())
        
        return footer
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard !firstLetters.isEmpty else {return 0}
        let key = firstLetters[section]
        return friendsDict[key]?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath) as! FriendTableViewCell
        
        let key = firstLetters[indexPath.section]
        let friendsForKey = friendsDict[key]
        guard let friend = friendsForKey?[indexPath.row] else { return cell }
        
        cell.nameLabel.text = friend.firstName + " " + friend.lastName
        cell.avatarImageView.image = imageService?.photo(atIndexpath: indexPath, byUrl: friend.avatarURL)
        
        return cell
    }
}
