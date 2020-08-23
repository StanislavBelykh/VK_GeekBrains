//
//  GetDataOperation.swift
//  VK_GeekBrains
//
//  Created by Станислав Белых on 04.07.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import Foundation

class GetDataOperation: AsyncOperation {
    
    private var urlConstructor = URLComponents()
    private let configuration: URLSessionConfiguration!
    private let session: URLSession!
    private let constants = NetworkConstants()
    private var urlRequest: URL
    private var task: URLSessionTask?
    
    var data: Data?

    override func cancel() {
        task?.cancel()
        super.cancel()
    }
    
    override func main() {
        task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            guard error == nil else {
                print(ServerError.errorTask)
                return
            }
            guard let data = data else {
                print(ServerError.noDataProvided)
                return
            }
            self.data = data
            self.state = .finished
        })
        task?.resume()
    }
    
    init(urlRequest: URL) {
        urlConstructor.scheme = constants.scheme
        urlConstructor.host = constants.host
        configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
        
        self.urlRequest = urlRequest
    }
    
}
