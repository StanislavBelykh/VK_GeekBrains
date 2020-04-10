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
    let photoView = PhotoView()
    let likeControl = LikeControl()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(avatarView)
        addSubview(labelCreator)
        addSubview(dateLabel)
        addSubview(titleLabel)
        addSubview(photoView)
        addSubview(likeControl)
        
        photoView.translatesAutoresizingMaskIntoConstraints = false
        likeControl.translatesAutoresizingMaskIntoConstraints = false
        
        avatarView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        avatarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        avatarView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        avatarView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        labelCreator.topAnchor.constraint(equalTo: topAnchor, constant:  8).isActive = true
        labelCreator.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor,constant: 8).isActive = true
        labelCreator.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: labelCreator.bottomAnchor, constant: 8).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 8).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: avatarView.bottomAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        
        photoView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        photoView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        photoView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        photoView.heightAnchor.constraint(equalToConstant: frame.width * 4/3).isActive = true
        
        likeControl.topAnchor.constraint(equalTo: photoView.bottomAnchor, constant: 8).isActive = true
        likeControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        likeControl.heightAnchor.constraint(equalToConstant: 15).isActive = true
        likeControl.widthAnchor.constraint(equalToConstant: 15).isActive = true
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
    
    var photos = [String]()
    
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
        
        if photos.count > 3 {
            addSubview(collageView1)
            addSubview(collageView2)
            addSubview(collageView3)
            addSubview(collageView4)
            collageView1.translatesAutoresizingMaskIntoConstraints = false
            collageView2.translatesAutoresizingMaskIntoConstraints = false
            collageView3.translatesAutoresizingMaskIntoConstraints = false
            collageView4.translatesAutoresizingMaskIntoConstraints = false
            
            collageView1.image = UIImage(named: photos[0])
            collageView2.image = UIImage(named: photos[1])
            collageView3.image = UIImage(named: photos[2])
            collageView4.image = UIImage(named: photos[3])
            
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
            
            imageView.image = UIImage(named: photos[0])
            
            imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        }
    }
}
