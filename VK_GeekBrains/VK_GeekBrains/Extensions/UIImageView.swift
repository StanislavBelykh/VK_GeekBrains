//
//  UIImageView.swift
//  VK_GeekBrains
//
//  Created by Станислав on 15.05.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(by imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        
        if let imageDate = cache.cachedResponse(for: request)?.data {
            self.image = UIImage(data: imageDate)
        } else {
            URLSession.shared.dataTask(with: request) { [unowned self] (data, response, _ ) in
                guard let data = data, let response = response else {
                    return
                }
                let cacheResponse = CachedURLResponse(response: response, data: data)
                cache.storeCachedResponse(cacheResponse, for: request)
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
                
            }.resume()
        }
    }
}

