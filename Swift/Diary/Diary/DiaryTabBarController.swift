//
//  DiaryTabBarController.swift
//  Diary
//
//  Created by Bumsang Kim on 2022/01/24.
//

import UIKit

class DiaryTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = .black
        self.tabBar.unselectedItemTintColor = .systemGray
    }
    
}
