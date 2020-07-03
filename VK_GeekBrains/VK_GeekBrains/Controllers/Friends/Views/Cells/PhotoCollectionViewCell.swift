//
//  PhotoCollectionViewCell.swift
//  VK_GeekBrains
//
//  Created by Станислав on 31.03.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let reusedID = "PhotoCollectionViewCell"
    
    private let likeControl = LikeControl()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let shadowView: UIView = {
        let shadowView = UIView()
        shadowView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        shadowView.layer.cornerRadius = 10
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        shadowView.layer.shadowOffset = CGSize(width: 4, height: 4)
        shadowView.layer.shadowRadius = 4
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        return shadowView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(shadowView)
        addSubview(imageView)
        
        setLikeControl()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            shadowView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            shadowView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            shadowView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            likeControl.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 0),
            likeControl.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
            likeControl.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.15),
            likeControl.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.15)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(image: UIImage?){
        imageView.image = image
    }
     
    private func setLikeControl() {
        addSubview(likeControl)
        likeControl.translatesAutoresizingMaskIntoConstraints = false
    }
}
