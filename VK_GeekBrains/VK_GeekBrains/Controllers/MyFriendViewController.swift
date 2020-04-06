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
    var lettersControl = LettersControl()
    
    var friends = Users().list
    var firstLettersOfFriends = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friends = friends.sorted(by: { (firstUser, secondUser) -> Bool in
            firstUser.name < secondUser.name
        })
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
extension MyFriendViewController: UITableViewDelegate{
    
 
}
extension MyFriendViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath) as! FriendTableViewCell
        let friend = friends[indexPath.row]
        cell.avatarImageView.image = UIImage(named: friend.avatar)
        cell.nameLabel.text = friend.name
        return cell
    } 
}
