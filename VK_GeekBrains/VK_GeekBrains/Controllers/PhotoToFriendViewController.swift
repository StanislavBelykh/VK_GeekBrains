//
//  PhotoToFriendViewController.swift
//  VK_GeekBrains
//
//  Created by Станислав on 30.03.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class PhotoToFriendViewController: UIViewController, PhotoToFriendViewControllerDelegate {
    
    private var galleryCollectionView = GalleryCollectionView()
    
    var photosToFriend = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        galleryCollectionView.presentDelegate = self
        view.addSubview(galleryCollectionView)
        galleryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        galleryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        galleryCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        galleryCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        galleryCollectionView.set(photos: photosToFriend)
        galleryCollectionView.reloadData()

    }
    func showPresenter(photos: [String], selectedPhoto: Int){
        let presentVC = PresenterViewController()
        presentVC.photos = photos
        presentVC.selectedPhoto = selectedPhoto
        presentVC.modalPresentationStyle = .automatic
        presentVC.modalTransitionStyle = .coverVertical
        navigationController?.pushViewController(presentVC, animated: true)
    }

}


