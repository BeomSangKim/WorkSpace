//
//  ViewController.swift
//  LEDBoard
//
//  Created by Bumsang Kim on 2022/01/01.
//

import UIKit

class ViewController: UIViewController, LEDBoardSettingDelegate {

    @IBOutlet weak var contantsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contantsLabel.textColor = .yellow
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingViewController = segue.destination as? SettingViewController {
            settingViewController.delegate = self
            settingViewController.ledText = self.contantsLabel.text
            settingViewController.textColor = self.contantsLabel.textColor
            settingViewController.backgroundColor = self.view.backgroundColor ?? .black
        }
    }
    
    func changedSetting(text: String?, textColor: UIColor, backgroundColor: UIColor) {
        if let text = text {
            self.contantsLabel.text = text
        }
        self.contantsLabel.textColor = textColor
        self.view.backgroundColor = backgroundColor 
    }
}

