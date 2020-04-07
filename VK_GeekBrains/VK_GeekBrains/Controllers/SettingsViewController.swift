//
//  SettingsViewController.swift
//  VK_GeekBrains
//
//  Created by Станислав on 03.04.2020.
//  Copyright © 2020 Станислав. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var settingsLabel: UILabel!
    
    let settingsPicker = SettingsPiker()
    
    let labelFirst = UILabel()
    let labelSecond = UILabel()
    let colorLabel = UILabel()
    
    let firstStepper = UIStepper()
    let secondStepper = UIStepper()
    
    let rSlider = UISlider()
    let gSlider = UISlider()
    let bSlider = UISlider()
    
    var settingsIsHidden = true
        
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setViews()
        setImageSettings()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func setImageSettings(){
        imageView.layer.borderWidth = SettingsSinglton.shared.borderWidth
        imageView.layer.cornerRadius = SettingsSinglton.shared.cornerRadius * 2
        imageView.layer.borderColor = SettingsSinglton.shared.borderColor
        
        shadowView.layer.cornerRadius = SettingsSinglton.shared.cornerRadius * 2
        shadowView.layer.shadowRadius = SettingsSinglton.shared.shadowRadius
        shadowView.layer.shadowOpacity = SettingsSinglton.shared.shadowOpacity
        shadowView.layer.shadowColor = SettingsSinglton.shared.shadowColor
    }
    //Расстановка всех элементов интерфейса настроек
    func  setViews(){
        
        view.addSubview(settingsPicker)
        settingsPicker.addTarget(self, action: #selector(setSettingsInterface), for: .valueChanged)
        
        settingsPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        settingsPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        settingsPicker.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: 20).isActive = true
        settingsPicker.heightAnchor.constraint(equalToConstant: 40).isActive = true
        settingsPicker.translatesAutoresizingMaskIntoConstraints = false
        
        labelFirst.isHidden = settingsIsHidden
        self.view.addSubview(labelFirst)
        labelFirst.translatesAutoresizingMaskIntoConstraints = false
        
        labelFirst.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor, constant: 100).isActive = true
        labelFirst.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        labelFirst.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        firstStepper.isHidden = settingsIsHidden
        self.view.addSubview(firstStepper)
        firstStepper.translatesAutoresizingMaskIntoConstraints = false
        firstStepper.addTarget(self, action: #selector(setFirstSettings), for: .primaryActionTriggered)
        
        firstStepper.centerYAnchor.constraint(equalTo: labelFirst.centerYAnchor).isActive = true
        firstStepper.leadingAnchor.constraint(equalTo: labelFirst.trailingAnchor, constant: 40).isActive = true

        labelSecond.isHidden = settingsIsHidden
        self.view.addSubview(labelSecond)
        labelSecond.translatesAutoresizingMaskIntoConstraints = false
        
        labelSecond.topAnchor.constraint(equalTo: labelFirst.bottomAnchor, constant: 20).isActive = true
        labelSecond.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        labelSecond.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        
        secondStepper.isHidden = settingsIsHidden
        self.view.addSubview(secondStepper)
        secondStepper.translatesAutoresizingMaskIntoConstraints = false
        
        secondStepper.addTarget(self, action: #selector(setFirstSettings), for: .primaryActionTriggered)
        
        secondStepper.centerYAnchor.constraint(equalTo: labelSecond.centerYAnchor).isActive = true
        secondStepper.leadingAnchor.constraint(equalTo: labelSecond.trailingAnchor, constant: 40).isActive = true

        colorLabel.isHidden = settingsIsHidden
        self.view.addSubview(colorLabel)
        colorLabel.textAlignment = .center
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        colorLabel.topAnchor.constraint(equalTo: labelSecond.bottomAnchor, constant: 30).isActive = true
        colorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        colorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        
        rSlider.isHidden = settingsIsHidden
        self.view.addSubview(rSlider)
        rSlider.translatesAutoresizingMaskIntoConstraints = false
        rSlider.minimumTrackTintColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        rSlider.thumbTintColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
        rSlider.maximumValue = 1
        rSlider.minimumValue = 0
        rSlider.addTarget(self, action: #selector(setFirstSettings), for: .valueChanged)

        
        rSlider.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 20).isActive = true
        rSlider.widthAnchor.constraint(equalToConstant: 200).isActive = true
        rSlider.centerXAnchor.constraint(equalTo: colorLabel.centerXAnchor).isActive = true
        
        gSlider.isHidden = settingsIsHidden
        self.view.addSubview(gSlider)
        gSlider.translatesAutoresizingMaskIntoConstraints = false
        gSlider.minimumTrackTintColor = #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)
        gSlider.thumbTintColor = #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1)
        gSlider.maximumValue = 1
        gSlider.minimumValue = 0
        gSlider.addTarget(self, action: #selector(setFirstSettings), for: .valueChanged)
        
        gSlider.topAnchor.constraint(equalTo: rSlider.bottomAnchor, constant: 20).isActive = true
        gSlider.widthAnchor.constraint(equalToConstant: 200).isActive = true
        gSlider.centerXAnchor.constraint(equalTo: colorLabel.centerXAnchor).isActive = true
        
        bSlider.isHidden = settingsIsHidden
        self.view.addSubview(bSlider)
        bSlider.translatesAutoresizingMaskIntoConstraints = false
        bSlider.minimumTrackTintColor = #colorLiteral(red: 0, green: 0, blue: 1, alpha: 1)
        bSlider.thumbTintColor = #colorLiteral(red: 0, green: 0, blue: 1, alpha: 1)
        bSlider.maximumValue = 1
        bSlider.minimumValue = 0
        bSlider.addTarget(self, action: #selector(setFirstSettings), for: .valueChanged)
        
        bSlider.topAnchor.constraint(equalTo: gSlider.bottomAnchor, constant: 20).isActive = true
        bSlider.widthAnchor.constraint(equalToConstant: 200).isActive = true
        bSlider.centerXAnchor.constraint(equalTo: colorLabel.centerXAnchor).isActive = true
        
    }
    
    @objc private func setSettingsInterface(){
 
        guard settingsPicker.selectView != nil else {
            return
        }
        settingsIsHidden = false
        
        switch settingsPicker.selectView! {
        case SelectView.image:
            
            labelFirst.text = "Ширина рамки"
            labelSecond.text = "Закругление"
            colorLabel.text = "Цвет рамки"
            
            firstStepper.value = Double(SettingsSinglton.shared.borderWidth)
            firstStepper.minimumValue = 0
            firstStepper.maximumValue = 10
            firstStepper.stepValue = 1
            
            secondStepper.value = Double(SettingsSinglton.shared.cornerRadius)
            secondStepper.minimumValue = 0
            secondStepper.maximumValue = 40
            secondStepper.stepValue = 5
            
            let arrColor = SettingsSinglton.shared.borderColor.components
            rSlider.value = Float(arrColor?[0] ?? 0)
            gSlider.value = Float(arrColor?[1] ?? 0)
            bSlider.value = Float(arrColor?[2] ?? 0)

        case SelectView.shadow:
            labelFirst.text = "Радиус тени"
            labelSecond.text = "Непрозрачность"
            colorLabel.text = "Цвет тени"
            
            firstStepper.value = Double(SettingsSinglton.shared.shadowRadius)
            firstStepper.minimumValue = 0
            firstStepper.maximumValue = 15
            firstStepper.stepValue = 1
            
            secondStepper.value = Double(SettingsSinglton.shared.shadowOpacity)
            secondStepper.minimumValue = 0
            secondStepper.maximumValue = 1
            secondStepper.stepValue = 0.1
            
            let arrColor = SettingsSinglton.shared.shadowColor.components
            rSlider.value = Float(arrColor?[0] ?? 0)
            gSlider.value = Float(arrColor?[1] ?? 0)
            bSlider.value = Float(arrColor?[2] ?? 0)
            
        }
        setViews()
    }
    
    @objc private func setFirstSettings(){
        switch settingsPicker.selectView! {
        case SelectView.image:
            SettingsSinglton.shared.borderWidth = CGFloat(firstStepper.value)
            SettingsSinglton.shared.cornerRadius = CGFloat(secondStepper.value)
            SettingsSinglton.shared.borderColor = CGColor(srgbRed: CGFloat(rSlider.value), green: CGFloat(gSlider.value), blue: CGFloat(bSlider.value), alpha: 1)
          
        case SelectView.shadow:
            
            SettingsSinglton.shared.shadowRadius = CGFloat(firstStepper.value)
            SettingsSinglton.shared.shadowOpacity = Float(secondStepper.value)
            SettingsSinglton.shared.shadowColor = CGColor(srgbRed: CGFloat(rSlider.value), green: CGFloat(gSlider.value), blue: CGFloat(bSlider.value), alpha: 1)
        }
        setImageSettings()
        SettingsSinglton.shared.notificate()
    }

}
