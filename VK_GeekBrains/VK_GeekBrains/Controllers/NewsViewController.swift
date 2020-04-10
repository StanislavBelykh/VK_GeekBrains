//
//  NewsViewController.swift
//  VK_GeekBrains
//
//  Created by Станислав on 10.04.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    let news = NewsFabric().list
    
    override func loadView() {
        super.loadView()
        self.view = NewsView()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
        view().newsTableView.news = news
        
    }
    
    func view() -> NewsView {
        return self.view as! NewsView
    }
}
