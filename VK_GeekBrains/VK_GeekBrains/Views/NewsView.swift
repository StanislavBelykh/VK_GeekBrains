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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(newsTableView)
        
        newsTableView.translatesAutoresizingMaskIntoConstraints = false
        newsTableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        newsTableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        newsTableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        newsTableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func setNews(news: [News]) {
        self.newsTableView.news = news
    }
}

class NewsTableView: UITableView {
    
    var news = [News]()
    
    init(){
        super.init(frame: .zero, style: .grouped)
        delegate = self
        dataSource = self
        
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = UITableView.automaticDimension
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reusedID)
        translatesAutoresizingMaskIntoConstraints = false
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension NewsTableView: UITableViewDelegate {

}

extension NewsTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: NewsTableViewCell.reusedID, for: indexPath) as! NewsTableViewCell

        let post = news[indexPath.row]
        cell.avatarView.image = UIImage(named: post.avatar)
        cell.labelCreator.text = post.creator
        cell.dateLabel.text = "Здесь будет дата"
        cell.titleLabel.text = post.title
        cell.photoView.photos = post.photos
        cell.likeControl.likeCounter = post.likeCount

        return cell
    }
    
    
}
