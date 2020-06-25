//
//  NewsTableViewCell.swift
//  VK_GeekBrains
//
//  Created by Станислав on 10.04.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    static let reusedID = "NewsTableViewCell"
    
    let avatarView: UIImageView = {
        let avatarView = UIImageView()
        avatarView.layer.cornerRadius = 15
        avatarView.layer.masksToBounds = true
        avatarView.contentMode = .scaleToFill
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        return avatarView
    }()
    let labelCreator: UILabel = {
        let labelCreator = UILabel()
        labelCreator.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        labelCreator.translatesAutoresizingMaskIntoConstraints = false
        return labelCreator
    }()
    let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        titleLabel.numberOfLines = 5
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    let commentCountLable: UILabel = {
        let commentCountLable = UILabel()
        commentCountLable.textColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        commentCountLable.translatesAutoresizingMaskIntoConstraints = false
        commentCountLable.text = ""
        return commentCountLable
    }()
    let commentButton: UIButton = {
        let commentButton = UIButton()
        commentButton.setImage(UIImage(systemName: "bubble.right"), for: .normal)
        commentButton.translatesAutoresizingMaskIntoConstraints = false
        return commentButton
    }()
    let repostButton: UIButton = {
        let repostButton = UIButton()
        repostButton.setImage(UIImage(systemName: "arrowshape.turn.up.left"), for: .normal)
        repostButton.translatesAutoresizingMaskIntoConstraints = false
        return repostButton
    }()
    
    var photoView = PhotoView()
    let likeControl = LikeControl()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(avatarView)
        contentView.addSubview(labelCreator)
        contentView.addSubview(dateLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(photoView)
        contentView.addSubview(likeControl)
        contentView.addSubview(commentCountLable)
        contentView.addSubview(commentButton)
        contentView.addSubview(repostButton)
        
        photoView.translatesAutoresizingMaskIntoConstraints = false
        likeControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            avatarView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            avatarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            avatarView.heightAnchor.constraint(equalToConstant: 50),
            avatarView.widthAnchor.constraint(equalToConstant: 50),
            
            labelCreator.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  8),
            labelCreator.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor,constant: 8),
            labelCreator.widthAnchor.constraint(equalToConstant: 150),
            
            dateLabel.topAnchor.constraint(equalTo: labelCreator.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 8),
            dateLabel.widthAnchor.constraint(equalToConstant: 150),
            
            titleLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            photoView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            photoView.heightAnchor.constraint(equalToConstant: frame.width * 4/3),
            
            likeControl.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 8),
            likeControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 60),
            likeControl.heightAnchor.constraint(equalToConstant: 20),
            likeControl.widthAnchor.constraint(equalToConstant: 20),
            likeControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            commentCountLable.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 8),
            commentCountLable.leadingAnchor.constraint(equalTo: likeControl.trailingAnchor, constant: 20),
            
            commentButton.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 8),
            commentButton.leadingAnchor.constraint(equalTo: commentCountLable.trailingAnchor, constant: 8),
            commentButton.heightAnchor.constraint(equalToConstant: 20),
            commentButton.widthAnchor.constraint(equalToConstant: 20),
            
            repostButton.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 8),
            repostButton.leadingAnchor.constraint(equalTo: commentButton.trailingAnchor, constant: 20),
            repostButton.heightAnchor.constraint(equalToConstant: 20),
            repostButton.widthAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(post: NewsModel, loadImages: @escaping () -> Void ){
        self.dateLabel.text = post.getStringDate()
        self.titleLabel.text = post.text
        self.likeControl.setLike(count: post.likes.count)
        self.commentCountLable.text = String(post.comments.count)
        self.labelCreator.text = post.creatorName
        self.avatarView.loadImage(by: post.avatarURL ?? "")
        
        DispatchQueue.main.async {
            loadImages()
        }
    }
}

