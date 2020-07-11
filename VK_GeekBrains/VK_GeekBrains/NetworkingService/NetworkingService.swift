//
//  NetworkingService.swift
//  VK_GeekBrains
//
//  Created by Станислав on 13.05.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import Foundation
import PromiseKit

class NetworkingService {
    
    private var urlConstructor = URLComponents()
    private let constants = NetworkConstants()
    private let configuration: URLSessionConfiguration!
    private let session: URLSession!
    
    init(){
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
    }
    
    func  getAuthorizeRequest() -> URLRequest? {
        urlConstructor.host = "oauth.vk.com"
        urlConstructor.path = "/authorize"
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "client_id", value: constants.clientID),
            URLQueryItem(name: "scope", value: constants.scope),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: constants.versionAPI)
        ]
        
        guard let url = urlConstructor.url else { return nil }
        let request = URLRequest(url: url)
        return request
    }
    
    //MARK: - Photo
    func getPhoto(for ownerID: Int?, onComplete: @escaping ([Photo]) -> Void, onError: @escaping (Error) -> Void) {
        
        
        urlConstructor.path = "/method/photos.getAll"
        
        guard let owner = ownerID else { return }
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "owner_id", value: String(owner)),
            URLQueryItem(name: "photo_sizes", value: "1"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "access_token", value: SessionApp.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI),
        ]
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in

            if error != nil {
                onError(ServerError.errorTask)
            }
            
            guard let data = data else {
                onError(ServerError.noDataProvided)
                return
            }
            guard let photos = try? JSONDecoder().decode(Response<Photo>.self, from: data).response.items else {
                onError(ServerError.failedToDecode)
                return
            }
            DispatchQueue.main.async {
                onComplete(photos)
            }
        }
        task.resume()
        
    }
    //MARK: - News feed
    func getNews(onComplete: @escaping ([NewsModel]) -> Void, onError: @escaping (Error) -> Void) {
        urlConstructor.path = "/method/newsfeed.get"
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "start_from", value: "next_from"),
            URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "access_token", value: SessionApp.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI),
        ]
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            
            if error != nil {
                onError(ServerError.errorTask)
            }
            
            guard let data = data else {
                onError(ServerError.noDataProvided)
                return
            }
            guard var news = try? JSONDecoder().decode(Response<NewsModel>.self, from: data).response.items else {
                onError(ServerError.failedToDecode)
                return
            }
            guard let profiles = try? JSONDecoder().decode(ResponseNews.self, from: data).response.profiles else {
                onError(ServerError.failedToDecode)
                print("Error profiles")
                return
            }
            guard let groups = try? JSONDecoder().decode(ResponseNews.self, from: data).response.groups else {
                onError(ServerError.failedToDecode)
                print("Error groups")
                return
            }
            for i in 0..<news.count {
                if news[i].sourceID < 0 {
                    let group = groups.first(where: { $0.id == -news[i].sourceID })
                    news[i].avatarURL = group?.avatarURL
                    news[i].creatorName = group?.name
                } else {
                    let profile = profiles.first(where: { $0.id == news[i].sourceID })
                    news[i].avatarURL = profile?.avatarURL
                    news[i].creatorName = profile?.firstName
                }
            }
            
            DispatchQueue.main.async {
                onComplete(news)
            }
        }
        DispatchQueue.global(qos: .utility).async {
            task.resume()
        }  
    }
    
    //MARK: - Community User
    func getCommunity(onComplete: @escaping ([Community]) -> Void, onError: @escaping (Error) -> Void) {
        urlConstructor.path = "/method/groups.get"

        urlConstructor.queryItems = [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "description"),
            URLQueryItem(name: "access_token", value: SessionApp.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI),
        ]
       
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in

            if error != nil {
                onError(ServerError.errorTask)
            }

            guard let data = data else {
                onError(ServerError.noDataProvided)
                return
            }
            guard let communities = try? JSONDecoder().decode(Response<Community>.self, from: data).response.items else {
                onError(ServerError.failedToDecode)
                return
            }
            onComplete(communities)
        }
        task.resume()
    }
    
    func getURLDataCommunites() -> URL? {
        urlConstructor.path = "/method/groups.get"

        urlConstructor.queryItems = [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "description"),
            URLQueryItem(name: "access_token", value: SessionApp.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI),
        ]
        return urlConstructor.url
    }
    func getSearchCommunity(text: String?, onComplete: @escaping ([Community]) -> Void, onError: @escaping (Error) -> Void) {
        urlConstructor.path = "/method/groups.search"
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "q", value: text),
            URLQueryItem(name: "access_token", value: SessionApp.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI),
        ]
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            
            if error != nil {
                onError(ServerError.errorTask)
            }
            
            guard let data = data else {
                onError(ServerError.noDataProvided)
                return
            }
            guard let communities = try? JSONDecoder().decode(Response<Community>.self, from: data).response.items else {
                onError(ServerError.failedToDecode)
                return
            }
            DispatchQueue.main.async {
                onComplete(communities)
            }
        }
        task.resume()
    }
    
    func joinCommunity(id: Int, onComplete: @escaping (Int) -> Void, onError: @escaping (Error) -> Void) {
        urlConstructor.path = "/method/groups.join"
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "group_id", value: String(id)),
            URLQueryItem(name: "access_token", value: SessionApp.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI),
        ]
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            
            if error != nil {
                onError(ServerError.errorTask)
            }
            
            guard let data = data else {
                onError(ServerError.noDataProvided)
                return
            }
            guard let response = try? JSONDecoder().decode(ResponseJoin.self, from: data) else {
                onError(ServerError.failedToDecode)
                return
            }
            DispatchQueue.main.async {
                onComplete(response.response)
            }
        }
        task.resume()
    }
    func leaveCommunity(id: Int, onComplete: @escaping (Int) -> Void, onError: @escaping (Error) -> Void) {
        urlConstructor.path = "/method/groups.leave"
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "group_id", value: String(id)),
            URLQueryItem(name: "access_token", value: SessionApp.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI),
        ]
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            
            if error != nil {
                onError(ServerError.errorTask)
            }
            
            guard let data = data else {
                onError(ServerError.noDataProvided)
                return
            }
            guard let response = try? JSONDecoder().decode(ResponseJoin.self, from: data) else {
                onError(ServerError.failedToDecode)
                return
            }
            DispatchQueue.main.async {
                onComplete(response.response)
            }
        }
        task.resume()
    }
    
    //MARK: - Friends User
    func getFriends(onComplete: @escaping ([Friend]) -> Void, onError: @escaping (Error) -> Void) {
        urlConstructor.path = "/method/friends.get"
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "fields", value: "sex, bdate, city, country, photo_100, photo_200_orig"),
            URLQueryItem(name: "access_token", value: SessionApp.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI),
        ]
        
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            
            if error != nil {
                onError(ServerError.errorTask)
            }
            
            guard let data = data else {
                onError(ServerError.noDataProvided)
                return
            }
            guard let friends = try? JSONDecoder().decode(Response<Friend>.self, from: data).response.items else {
                onError(ServerError.failedToDecode)
                return
            }
            DispatchQueue.main.async {
                onComplete(friends)
            }
        }
        task.resume()
    }
    //MARK: - Promise Friends request
    func getFriendsPromise() -> Promise<[Friend]> {
        urlConstructor.path = "/method/friends.get"
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "fields", value: "sex, bdate, city, country, photo_100, photo_200_orig"),
            URLQueryItem(name: "access_token", value: SessionApp.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI),
        ]
        
        return Promise { resolver in
            session.dataTask(with: urlConstructor.url!){ (data, response, error) in
                
                if error != nil {
                    resolver.reject(ServerError.errorTask)
                }
                
                guard let data = data else {
                    resolver.reject(ServerError.noDataProvided)
                    return
                }
                
                guard let friends = try? JSONDecoder().decode(Response<Friend>.self, from: data).response.items else {
                    resolver.reject(ServerError.failedToDecode)
                    return
                }
                resolver.fulfill(friends)
            }.resume()
        }
    }
    
    func getOnlineFriends(onComplete: @escaping ([Friend]) -> Void, onError: @escaping (Error) -> Void) {
        urlConstructor.path = "/method/friends.getOnline"
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "fields", value: "sex, bdate, city, country, photo_100, photo_200_orig"),
            URLQueryItem(name: "access_token", value: SessionApp.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI),
        ]
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            
            if error != nil {
                onError(ServerError.errorTask)
            }
            
            guard let data = data else {
                onError(ServerError.noDataProvided)
                return
            }
            guard let friends = try? JSONDecoder().decode(Response<Friend>.self, from: data).response.items else {
                onError(ServerError.failedToDecode)
                return
            }
            DispatchQueue.main.async {
                onComplete(friends)
            }
        }
        task.resume()
        
    }
    
    //MARK: -  Files User
    func getFiles( onComplete: @escaping ([FileModel]) -> Void, onError: @escaping (Error) -> Void){
        
        urlConstructor.path = "/method/docs.get"
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "count", value: "0"),
            URLQueryItem(name: "type", value: "0"),
            URLQueryItem(name: "access_token", value: SessionApp.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI),
        ]
        
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            
            if error != nil {
                onError(ServerError.errorTask)
            }
            
            guard let data = data else {
                onError(ServerError.noDataProvided)
                return
            }
            
            guard let files = try? JSONDecoder().decode(Response<FileModel>.self, from: data).response.items else {
                onError(ServerError.failedToDecode)
                return
            }
            DispatchQueue.main.async {
                onComplete(files)
            }
        }
        task.resume()
    }
    
    func editFile(id: Int, newName name: String, onComplete: @escaping () -> Void, onError: @escaping (Error) -> Void){
        
        urlConstructor.path = "/method/docs.edit"
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "doc_id", value: "\(id)"),
            URLQueryItem(name: "title", value: "\(name)"),
            URLQueryItem(name: "access_token", value: SessionApp.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI),
        ]
        
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            if error != nil {
                onError(ServerError.errorTask)
            }
            
            if response != nil {
                onComplete()
            }
        }
        task.resume()
    }
    
    func deleteFile(file: FileModel, onComplete: @escaping () -> Void, onError: @escaping (Error) -> Void){
        
        urlConstructor.path = "/method/docs.delete"
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "owner_id", value: "\(file.ownerID)"),
            URLQueryItem(name: "doc_id", value: "\(file.id)"),
            URLQueryItem(name: "access_token", value: SessionApp.shared.token),
            URLQueryItem(name: "v", value: constants.versionAPI),
        ]
        
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            if error != nil {
                onError(ServerError.errorTask)
            }
            
            if response != nil {
                DispatchQueue.main.async {
                    onComplete()
                }
            }
        }
        task.resume()
    }

    func downloadFile(_ file: FileModel, isUserInitiated: Bool, completion: @escaping (_ success: Bool,_ filrLocation: URL?) -> Void){
        
        let fileURL = URL(string: file.url)
        
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let destinationURL = documentDirectoryURL.appendingPathComponent("\(file.id)" + "." + "\(file.ext)" )
        
        if FileManager.default.fileExists(atPath: destinationURL.path) {
            
            debugPrint("Файл уже был загружен")
            completion(true, destinationURL)
            
        } else if isUserInitiated{
            
            URLSession.shared.downloadTask(with: fileURL!, completionHandler: { (location, response, error) -> Void in
                guard let tempLocation = location, error == nil else { return }
                
                do {
                    try FileManager.default.moveItem(at: tempLocation, to: destinationURL)
                    completion(true, destinationURL)
                    print("Файл загружен")
                } catch let error as NSError {
                    print(error.localizedDescription)
                    completion(false,nil)
                }
            }).resume()
        }
    }
}
