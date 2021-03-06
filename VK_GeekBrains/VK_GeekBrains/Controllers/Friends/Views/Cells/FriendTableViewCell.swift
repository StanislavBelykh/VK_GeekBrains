//
//  FriendTableViewCell.swift
//  VK_GeekBrains
//
//  Created by Станислав on 31.03.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var shadowView: ShadowView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapOnAvatar(_:)))
        avatarImageView.addGestureRecognizer(tap)
        avatarImageView.isUserInteractionEnabled = true
    }
    
    func configure(nameLabelText: String?, avatarImage: UIImage?){
        nameLabel.text = nameLabelText
        avatarImageView.image = avatarImage
    }

    @objc func tapOnAvatar(_ tapGestureRecognizer: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.3,
                       initialSpringVelocity: 1,
                       options: [.autoreverse],
                       animations: { [unowned self] in
                        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                        self.avatarImageView.transform = scale
                        self.shadowView.transform = scale
        }) { [unowned self] _ in
            self.avatarImageView.transform = .identity
            self.shadowView.transform = .identity
        }
    }
}
