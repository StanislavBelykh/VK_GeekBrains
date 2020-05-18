//
//  NetworkingService.swift
//  VK_GeekBrains
//
//  Created by Станислав on 13.05.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import Foundation

class NetworkingService {
    
    var urlConstructor = URLComponents()
    let constants = NetworkConstants()
    let configuration: URLSessionConfiguration!
    let session: URLSession!
    
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
            URLQueryItem(name: "access_token", value: Session.shared.token),
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
            URLQueryItem(name: "access_token", value: Session.shared.token),
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
            guard let news = try? JSONDecoder().decode(Response<NewsModel>.self, from: data).response.items else {
                onError(ServerError.failedToDecode)
                return
            }
            DispatchQueue.main.async {
                onComplete(news)
            }
        }
        task.resume()
        
    }
    
    //MARK: - Community User
    func getCommunity(onComplete: @escaping ([Community]) -> Void, onError: @escaping (Error) -> Void) {
        urlConstructor.path = "/method/groups.get"
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "description"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
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
    func getSearchCommunity(text: String?, onComplete: @escaping ([Community]) -> Void, onError: @escaping (Error) -> Void) {
        urlConstructor.path = "/method/groups.search"
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "q", value: text),
            URLQueryItem(name: "access_token", value: Session.shared.token),
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
    
    
    //MARK: - Friends User
    func getFriends(onComplete: @escaping ([Friend]) -> Void, onError: @escaping (Error) -> Void) {
        urlConstructor.path = "/method/friends.get"
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "fields", value: "sex, bdate, city, country, photo_100, photo_200_orig"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
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
    
    func getOnlineFriends(onComplete: @escaping ([Friend]) -> Void, onError: @escaping (Error) -> Void) {
        urlConstructor.path = "/method/friends.getOnline"
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "order", value: "name"),
            URLQueryItem(name: "fields", value: "sex, bdate, city, country, photo_100, photo_200_orig"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
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
            URLQueryItem(name: "access_token", value: Session.shared.token),
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
            URLQueryItem(name: "access_token", value: Session.shared.token),
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
            URLQueryItem(name: "access_token", value: Session.shared.token),
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
    // Стоит вынести в отдельный класс?
    func downloadFile(_ file: FileModel, isUserInitiated: Bool, completion: @escaping (_ success: Bool,_ filrLocation: URL?) -> Void){
        
        let fileURL = URL(string: file.url)
        
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let destinationURL = documentDirectoryURL.appendingPathComponent("\(file.id)" + "." + "\(file.ext)" )
        
        if FileManager.default.fileExists(atPath: destinationURL.path){
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
