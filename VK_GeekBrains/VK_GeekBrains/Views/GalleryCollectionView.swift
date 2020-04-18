//
//  GalleryCollectionView.swift
//  VK_GeekBrains
//
//  Created by Станислав on 31.03.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class GalleryCollectionView: UICollectionView{

    var photos = [String]()
    
    weak var presentDelegate: PhotoToFriendViewControllerDelegate?

    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        delegate = self
        dataSource = self

        
        register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reusedID)
        
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        
        layout.minimumLineSpacing = Constants.galleryMinimumLineSpacing
        contentInset = UIEdgeInsets(top: Constants.topDistanceToView, left: Constants.leftDistanceToView, bottom: 0, right: Constants.rightDistanceToView)
    
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(photos: [String]) {
        self.photos = photos
    }

}
extension GalleryCollectionView: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentDelegate?.showPresenter(photos: photos, selectedPhoto: indexPath.item)
    }
}
extension GalleryCollectionView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reusedID, for: indexPath) as! PhotoCollectionViewCell
        cell.imageView.image = UIImage(named: photos[indexPath.item])
        return cell
    }
}
extension GalleryCollectionView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: Constants.galleryItemWidth, height: Constants.galleryItemWidth)
    }
}
struct Constants {
    static let leftDistanceToView: CGFloat = 20
    static let rightDistanceToView: CGFloat = 20
    static let topDistanceToView: CGFloat = 20
    static let galleryMinimumLineSpacing: CGFloat = 10
    static let galleryItemWidth = (UIScreen.main.bounds.width - Constants.leftDistanceToView - Constants.rightDistanceToView - Constants.galleryMinimumLineSpacing) / 2
}

protocol  PhotoToFriendViewControllerDelegate: class {
    func showPresenter(photos: [String], selectedPhoto: Int )
}
