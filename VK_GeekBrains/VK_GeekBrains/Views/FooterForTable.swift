//
//  FooterForTable.swift
//  VK_GeekBrains
//
//  Created by Станислав on 08.04.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class FooterForTable: UIView {
    
    let label = UILabel()
    let line = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setViews()
    }
    
    func setViews(){
        addSubview(line)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        line.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        line.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        line.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        line.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 14
        label.clipsToBounds = true
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        
        
        
        
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: 50).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        
    }
}
