//
//  NewsView.swift
//  VK_GeekBrains
//
//  Created by Станислав on 10.04.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class NewsView: UIView {
    var newsTableView = NewsTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(newsTableView)
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubview(newsTableView)
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            newsTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            newsTableView.topAnchor.constraint(equalTo: topAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
    }
    
    func setNews(news: [NewsModel]) {
        self.newsTableView.news = news
    }
}



