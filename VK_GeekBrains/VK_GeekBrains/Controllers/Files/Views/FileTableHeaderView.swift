//
//  FileTableHeaderView.swift
//  VK_GeekBrains
//
//  Created by Станислав Белых on 21.05.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class FileTableHeaderView: UIView {
    weak var delegate: TableHeaderControlsDelegate?
    
    let sortButton: UIButton = {
        let sortButton = UIButton()
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        sortButton.setTitle("Сортировка по имени", for: .normal)
        sortButton.titleLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        sortButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        sortButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        sortButton.addTarget(self, action: #selector(selectSort), for: .touchUpInside)
        return sortButton
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        addSubview(sortButton)
        
        
        NSLayoutConstraint.activate([
            sortButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            sortButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            sortButton.widthAnchor.constraint(equalToConstant: 200)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selectSort(){
        delegate?.selectSort()
        
    }
}

protocol TableHeaderControlsDelegate: class  {
    func selectSort()
}

