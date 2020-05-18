//
//  PhotoToFriendViewController.swift
//  VK_GeekBrains
//
//  Created by Станислав on 30.03.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class PhotoToFriendViewController: UIViewController, PhotoToFriendViewControllerDelegate {
    
    var galleryCollectionView = GalleryCollectionView()
    var userID: Int?
    
    let networkService = NetworkingService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        galleryCollectionView.presentDelegate = self
        view.addSubview(galleryCollectionView)
        galleryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        galleryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        galleryCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        galleryCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        networkService.getPhoto(for: userID, onComplete: { [weak self] (photos) in
            self?.galleryCollectionView.set(photos: photos)
            self?.galleryCollectionView.reloadData()
        }) { (error) in
            print(error)
        }
    }
    
    func showPresenter(photos: [Photo], selectedPhoto: Int){
        let presentVC = PresenterViewController()
        presentVC.photos = photos
        presentVC.selectedPhoto = selectedPhoto
        presentVC.modalPresentationStyle = .automatic
        presentVC.modalTransitionStyle = .coverVertical
        navigationController?.pushViewController(presentVC, animated: true)
    }

}


