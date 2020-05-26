//
//  RealmManager.swift
//  VK_GeekBrains
//
//  Created by Станислав Белых on 22.05.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    var networkService: NetworkingService?
    var friends: [Friend]? {
        get {
            do {
                let realm = try Realm()
                //print(realm.configuration.fileURL)
                let friends = realm.objects(Friend.self)
                return Array(friends)
            } catch {
                return nil
            }
        }
        set {
            NotificationCenter.default.post(name: RealmNotification.friendsUpdate.name(), object: nil)
        }
    }
    var communites: [Community]? {
        get {
            do {
                let realm = try Realm()
                //print(realm.configuration.fileURL)
                let communites = realm.objects(Community.self)
                return Array(communites)
            } catch {
                return nil
            }
        }
        set {
            NotificationCenter.default.post(name: RealmNotification.communitesUpdate.name(), object: nil)
        }
    }
    
    init() {
        networkService = NetworkingService()
    }
    
    func updateFriends(){
        networkService?.getFriends(onComplete: { [weak self] (friends) in
            do {
                let realm = try Realm()
                let oldValues = realm.objects(Friend.self)
                realm.beginWrite()
                realm.delete(oldValues)
                realm.add(friends)
                try realm.commitWrite()
                self?.friends = friends
            } catch {
                print(error)
            }
            }, onError: { (error) in
                print(error)
        })
    }
    func updateCommunites(){
        networkService?.getCommunity(onComplete: { [weak self] (communites) in
            do {
                let realm = try Realm()
                let oldValues = realm.objects(Community.self)
                realm.beginWrite()
                realm.delete(oldValues)
                realm.add(communites)
                try realm.commitWrite()
                self?.communites = communites
            } catch {
                print(error)
            }
            }, onError: { (error) in
                print(error)
        })
    }
    
    private func updatePhotos(for userID: Int? ){
        networkService?.getPhoto(for: userID, onComplete: { (photos) in
            do {
                let realm = try Realm()
                let oldValues = realm.objects(Photo.self).filter("ownerID == %@", userID ?? -1)
                realm.beginWrite()
                realm.delete(oldValues)
                realm.add(photos)
                try realm.commitWrite()
                NotificationCenter.default.post(name: RealmNotification.photosUpdate.name(), object: nil)
            } catch {
                print(error)
            }
        }, onError: { (error) in
            print(error)
        })
    }
    func getPhotos(for userID: Int?, update: Bool) -> [Photo]?{
        if update {
            self.updatePhotos(for: userID)
        }
        do {
            let realm = try Realm()
            //print(realm.configuration.fileURL)
            let photosRealm = realm.objects(Photo.self)
            let photos = Array(photosRealm).filter{ $0.ownerID == userID}
        
            return photos
        } catch {
            return nil
        }
    }
}

enum RealmNotification {
    
    case friendsUpdate
    case communitesUpdate
    case photosUpdate
    
    func name() -> Notification.Name {
        switch self {
        case .friendsUpdate:
            return Notification.Name("friendsUpdateNotification")
        case .communitesUpdate:
            return Notification.Name("communitesUpdateNotification")
        case .photosUpdate:
            return Notification.Name("photosUpdateNotification")
        }
    }
}
