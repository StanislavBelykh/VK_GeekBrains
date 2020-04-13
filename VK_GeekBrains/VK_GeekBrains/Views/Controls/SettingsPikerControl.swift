//
//  SettingsPikerControl.swift
//  VK_GeekBrains
//
//  Created by Станислав on 03.04.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

enum SelectView: Int, CaseIterable {
    case image
    case shadow
    
    var title: String{
        switch self {
        case .image:
            return "Изображение"
        case .shadow:
            return "Тень"
        }
    }
}

class SettingsPiker: UIControl {
    
        var selectView: SelectView? = nil {
        didSet {
            self.updateSelectView()
            self.sendActions(for: .valueChanged)
        }
    }
    
    private var buttons: [UIButton] = []
    private var stackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stackView.frame = bounds
    }
    
    private func setupView() {
        for view in SelectView.allCases {
            let button = UIButton(type: .system)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            button.setTitle(view.title, for: .normal)
            button.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
            button.setTitleColor(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), for: .selected)
            button.addTarget(self, action: #selector(selectedView(_:)), for: .touchUpInside)
            self.buttons.append(button)
        }
        
        stackView = UIStackView(arrangedSubviews: self.buttons)
        
        self.addSubview(stackView)
        
        stackView.spacing = 0
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
    }
    
    private func updateSelectView() {
        for (index, button) in self.buttons.enumerated() {
            guard let view = SelectView(rawValue: index) else {continue}
            button.isSelected = view == self.selectView
        }
    }
    
    @objc private func selectedView(_ sender: UIButton) {
        guard let index = self.buttons.firstIndex(of: sender) else { return }
        guard let view = SelectView(rawValue: index) else { return }
        self.selectView = view
    }
    
}
