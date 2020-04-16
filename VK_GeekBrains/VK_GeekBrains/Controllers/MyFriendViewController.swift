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
    
    let data = Users()
    var friendsDict = [Character:[User]]()
    var firstLetters: [Character] {
        get {
            friendsDict.keys.sorted()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsDict = Users().getSortedUsers(searchText: nil)
        
        setSearchController()
        setLettersControl()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FriendsToPhotoSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! PhotoToFriendViewController
                let users = friendsDict[firstLetters[indexPath.section]]
                let user = users?[indexPath.row]
                controller.photosToFriend = user?.image ?? [String]()
                controller.title = user?.name
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
        friendsDict = data.getSortedUsers(searchText: searchText)
        if searchText == "" {
            lettersControl.isHidden = false
        }else{
            lettersControl.isHidden = true
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
        if searchBarIsEmpty {
            return friendsDict.keys.count
        } else {
            return 1
        }
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if searchBarIsEmpty {
            let footer = FooterForTable()
            footer.label.text = String(firstLetters[section].uppercased())
            return footer
        } else {
            let footer = FooterForSearch()
            return footer
        }
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
        let friend = friendsForKey?[indexPath.row]
        
        cell.avatarImageView.image = UIImage(named: friend?.avatar ?? "logo")
        cell.nameLabel.text = friend?.name
        return cell
    }
}
