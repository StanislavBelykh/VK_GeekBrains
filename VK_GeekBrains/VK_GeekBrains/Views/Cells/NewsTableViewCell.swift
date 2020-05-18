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
    
    let photoView = PhotoView()
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
            likeControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
            likeControl.heightAnchor.constraint(equalToConstant: 20),
            likeControl.widthAnchor.constraint(equalToConstant: 20),
            likeControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            commentButton.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 8),
            commentButton.leadingAnchor.constraint(equalTo: likeControl.trailingAnchor, constant: 20),
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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        
    }

}

class  PhotoView: UIView {
    
    var photos: [UIImage?]?
    
    let imageView = UIImageView()
    let collageView1 = UIImageView()
    let collageView2 = UIImageView()
    let collageView3 = UIImageView()
    let collageView4 = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setImages()
    }
    
    func setImages(){
        guard let photos = photos, !photos.isEmpty else {
            return
        }
        if photos.count > 3 {
            addSubview(collageView1)
            addSubview(collageView2)
            addSubview(collageView3)
            addSubview(collageView4)
            collageView1.translatesAutoresizingMaskIntoConstraints = false
            collageView2.translatesAutoresizingMaskIntoConstraints = false
            collageView3.translatesAutoresizingMaskIntoConstraints = false
            collageView4.translatesAutoresizingMaskIntoConstraints = false
            
            collageView1.image = photos[0]
            collageView2.image = photos[1]
            collageView3.image = photos[2]
            collageView4.image = photos[3]
            
            collageView1.topAnchor.constraint(equalTo: topAnchor).isActive = true
            collageView1.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            collageView1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -frame.width/4).isActive = true
            collageView1.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            
            collageView2.topAnchor.constraint(equalTo: topAnchor).isActive = true
            collageView2.leadingAnchor.constraint(equalTo: collageView1.trailingAnchor).isActive = true
            collageView2.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            collageView2.heightAnchor.constraint(equalToConstant: frame.height/3).isActive = true
            
            collageView3.topAnchor.constraint(equalTo: collageView2.bottomAnchor).isActive = true
            collageView3.leadingAnchor.constraint(equalTo: collageView1.trailingAnchor).isActive = true
            collageView3.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            collageView3.heightAnchor.constraint(equalToConstant: frame.height/3).isActive = true
            
            collageView4.topAnchor.constraint(equalTo: collageView3.bottomAnchor).isActive = true
            collageView4.leadingAnchor.constraint(equalTo: collageView1.trailingAnchor).isActive = true
            collageView4.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            collageView4.heightAnchor.constraint(equalToConstant: frame.height/3).isActive = true
            
        } else {
            addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            imageView.image = photos[0]
            
            imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
    }
}
