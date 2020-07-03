//
//  AllCommunityTableViewCell.swift
//  VK_GeekBrains
//
//  Created by Станислав on 31.03.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class AllCommunityTableViewCell: UITableViewCell {

    @IBOutlet private weak var imageCommunityView: UIImageView!
    @IBOutlet private weak var shadowView: ShadowView!
    @IBOutlet private weak var nameCommunityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapOnAvatar(_:)))
        imageCommunityView.addGestureRecognizer(tap)
        imageCommunityView.isUserInteractionEnabled = true
    }
    
    func configure(imageCommunity: UIImage?, nameCommunity: String?) {
        nameCommunityLabel.text = nameCommunity
        imageCommunityView.image = imageCommunity
    }
    @objc func tapOnAvatar(_ tapGestureRecognizer: UITapGestureRecognizer){
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.1,
                       initialSpringVelocity: 1,
                       options: [.autoreverse],
                       animations: { [unowned self] in
                        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                        self.imageCommunityView.transform = scale
                        self.shadowView.transform = scale
                        
        }) { [unowned self] _ in
            self.imageCommunityView.transform = .identity
            self.shadowView.transform = .identity
            print(#function)
        }
    }
}
