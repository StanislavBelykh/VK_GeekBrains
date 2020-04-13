//
//  LettersControl.swift
//  VK_GeekBrains
//
//  Created by Станислав on 05.04.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class LettersControl: UIControl {
    
    var selectedLetter: Character? = nil {
        didSet{
            self.sendActions(for: [.touchUpInside])
        }
    }
    var arrChar = [Character]() {
        didSet{
            self.setupView()
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
    
    func setupView(){
        for letter in arrChar {
            let button = UIButton(type: .system)
            button.backgroundColor = .clear
            button.setTitle(String(letter.uppercased()), for: .normal)
            button.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
            button.setTitleColor(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), for: .selected)
            button.addTarget(self, action: #selector(selectedLetter(_:)), for: [.touchUpInside])
            self.buttons.append(button)
        }
        
        stackView = UIStackView(arrangedSubviews: self.buttons)
        
        self.addSubview(stackView)
        
        stackView.spacing = 0
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
    }
    
    private func updateSelectView() {
        for (index, button) in self.buttons.enumerated() {
            let letter = arrChar[index]
            button.isSelected = letter == self.selectedLetter
        }
    }
    
    @objc private func selectedLetter(_ sender: UIButton) {
        guard let index = self.buttons.firstIndex(of: sender) else { return }
        let letter = arrChar[index]
        self.selectedLetter = letter
    }
}
