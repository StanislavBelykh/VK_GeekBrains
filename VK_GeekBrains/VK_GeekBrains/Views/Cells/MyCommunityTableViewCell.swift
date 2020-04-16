//
//  MyCommunityTableViewCell.swift
//  VK_GeekBrains
//
//  Created by Станислав on 31.03.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class MyCommunityTableViewCell: UITableViewCell {

    @IBOutlet weak var imageCommunityView: UIImageView!
    @IBOutlet weak var shadowView: ShadowView!
    
    @IBOutlet weak var nameCommunitylabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapOnAvatar(_:)))
        imageCommunityView.addGestureRecognizer(tap)
        imageCommunityView.isUserInteractionEnabled = true
    }
    @objc func tapOnAvatar(_ tapGestureRecognizer: UITapGestureRecognizer){
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.1,
                       initialSpringVelocity: 1,
                       options: [.autoreverse],
                       animations: {
                        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                        self.imageCommunityView.transform = scale
                        self.shadowView.transform = scale
                        
        }) { _ in
            self.imageCommunityView.transform = .identity
            self.shadowView.transform = .identity
            print(#function)
        }
    }
}
