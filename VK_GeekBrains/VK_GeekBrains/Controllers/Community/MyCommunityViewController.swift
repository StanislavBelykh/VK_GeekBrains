//
//  MyCommunityViewController.swift
//  VK_GeekBrains
//
//  Created by Станислав on 30.03.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit
import RealmSwift
import FirebaseDatabase

class MyCommunityViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private var communitesFirebase = [FirebaseCommunity]()
    private let ref = Database.database().reference(withPath: "Users") //.child( String(Session.shared.userID!))
    
    private let networkService = NetworkingService()
    private var realmManager = RealmManager()
    private var imageService: ImageService?
    
    private var myCommunites = [Community]()
    
    private var communites: Results<Community>?
    private var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageService = ImageService(container: tableView)
        
        realmManager.updateCommunites()
        pairTableAndRealm()
        
        ref.observe(.value, with: { snapshot in
            var communities: [FirebaseCommunity] = []
           
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let city = FirebaseCommunity(snapshot: snapshot) {
                    communities.append(city)
                }
            }
            print("Обновлен список добавленных групп")
            communities.forEach{ print($0.name) }
            print(communities.count)
        })
    }
    
    private func pairTableAndRealm() {
        guard let realm = try? Realm() else { return }
        communites = realm.objects(Community.self)
        token = communites?.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }

    @IBAction private func addCommunity(segue: UIStoryboardSegue){
        if segue.identifier == "addCommunitySegue" {
            let allCommunityController = segue.source as! AllCommunityViewController
            guard let index = allCommunityController.didSelectIndexCommunity else { return }
            
            let community = allCommunityController.communites[index]
            networkService.joinCommunity(id: community.id, onComplete: { [weak self] (value) in
                guard value == 1 else {
                    print("Запрос отклонен")
                    return
                }
                
                let fireUser = FirebaseUser(id: Session.shared.userID!)
                fireUser.communities.append(FirebaseCommunity(name: community.name, id: community.id))
                
                let userRef = self?.ref.child(String(Session.shared.userID!))
                userRef?.setValue(fireUser.toAnyObject())
                
                print("Запрос на вступление в группу отправлен")
                DispatchQueue.main.async {
                    self?.realmManager.updateCommunites()
                }
            }, onError: { (error) in
                print(error)
            })
        }
    }
}
//MARK: - UITableViewDelegate
extension MyCommunityViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction{
        let action = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completion) in
            if let community = self?.communites?[indexPath.row] {
                self?.networkService.leaveCommunity(id: community.id, onComplete: { (value) in
                    if value == 1 {
                        print("Успешно вышли из группы")
                        self?.realmManager.updateCommunites()
                    } else {
                        print("Ошибка запроса")
                    }
                }) { (error) in
                    print(error)
                }
                completion(true)
            }
        }
        action.backgroundColor = .red
        action.image = UIImage(systemName: "trash.fill")
        
        return action
    }
    
}
//MARK: - UITableViewDataSource
extension MyCommunityViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communites?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCommunityCell", for: indexPath) as! MyCommunityTableViewCell
        
        guard let community = communites?[indexPath.row] else { return cell}
  
        cell.nameCommunitylabel.text = community.name
        cell.imageCommunityView.image = imageService?.photo(atIndexpath: indexPath, byUrl: community.avatarURL)
        
        return cell
    }
}
