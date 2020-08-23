//
//  FileTableView.swift
//  VK_GeekBrains
//
//  Created by Станислав Белых on 21.05.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class FileTableView: UITableView {
    let header = FileTableHeaderView(frame: .init(x: 0, y: 0, width: 0, height: 50))
    
    init(){
        super.init(frame: .zero, style: .grouped)
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        separatorColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        
        //Cell
        register(FileTableViewCell.self, forCellReuseIdentifier: FileTableViewCell.reusedID)
        rowHeight = 56
        estimatedRowHeight = UITableView.automaticDimension
        translatesAutoresizingMaskIntoConstraints = false
        //Header
        tableHeaderView?.isHidden = false
        tableHeaderView = header
        tableHeaderView?.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
