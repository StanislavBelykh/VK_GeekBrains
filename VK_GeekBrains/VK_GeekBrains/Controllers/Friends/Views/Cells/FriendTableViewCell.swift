//
//  FriendTableViewCell.swift
//  VK_GeekBrains
//
//  Created by Станислав on 31.03.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var shadowView: ShadowView!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapOnAvatar(_:)))
        avatarImageView.addGestureRecognizer(tap)
        avatarImageView.isUserInteractionEnabled = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    @objc func tapOnAvatar(_ tapGestureRecognizer: UITapGestureRecognizer){
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 1,
                       options: [.autoreverse],
                       animations: {
                        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                        self.avatarImageView.transform = scale
                        self.shadowView.transform = scale
                        
        }) { _ in
            self.avatarImageView.transform = .identity
            self.shadowView.transform = .identity
        }
    }
}
