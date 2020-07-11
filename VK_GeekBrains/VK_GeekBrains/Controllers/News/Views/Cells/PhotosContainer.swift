//
//  PhotosContainer.swift
//  VK_GeekBrains
//
//  Created by Станислав Белых on 25.06.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class  PhotoView: UIView {
    private var imageView = UIImageView()
    private var collageView1 = UIImageView()
    private var collageView2 = UIImageView()
    private var collageView3 = UIImageView()
    private var collageView4 = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setImages()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setImages()
    }
    func setImages(photos: [UIImage?] = []){
        guard !photos.isEmpty else { return }
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
            
            NSLayoutConstraint.activate([
                collageView1.topAnchor.constraint(equalTo: topAnchor),
                collageView1.leadingAnchor.constraint(equalTo: leadingAnchor),
                collageView1.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -frame.width/4),
                collageView1.bottomAnchor.constraint(equalTo: bottomAnchor),
                
                collageView2.topAnchor.constraint(equalTo: topAnchor),
                collageView2.leadingAnchor.constraint(equalTo: collageView1.trailingAnchor),
                collageView2.trailingAnchor.constraint(equalTo: trailingAnchor),
                collageView2.heightAnchor.constraint(equalToConstant: frame.height/3),
                
                collageView3.topAnchor.constraint(equalTo: collageView2.bottomAnchor),
                collageView3.leadingAnchor.constraint(equalTo: collageView1.trailingAnchor),
                collageView3.trailingAnchor.constraint(equalTo: trailingAnchor),
                collageView3.heightAnchor.constraint(equalToConstant: frame.height/3),
                
                collageView4.topAnchor.constraint(equalTo: collageView3.bottomAnchor),
                collageView4.leadingAnchor.constraint(equalTo: collageView1.trailingAnchor),
                collageView4.trailingAnchor.constraint(equalTo: trailingAnchor),
                collageView4.heightAnchor.constraint(equalToConstant: frame.height/3)
            ])
        } else {
            addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            imageView.image = photos[0]
            
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: topAnchor),
                imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
            
        }
    }
}
