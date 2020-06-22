//
//  NewsViewController.swift
//  VK_GeekBrains
//
//  Created by Станислав on 10.04.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    
    let networkService = NetworkingService()
    
    override func loadView() {
        super.loadView()
        self.view = NewsView()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.getNews(onComplete: { (news) in
            print(news)
            self.view().newsTableView.news = news
            self.view().newsTableView.reloadData()
        }) { (error) in
            print(error)
        }
        title = "Новости"
        

    }
    
    func view() -> NewsView {
        return self.view as! NewsView
    }
}
