//
//  SeguePresentViewController.swift
//  ScreenTransition
//
//  Created by Bumsang Kim on 2021/12/21.
//

import UIKit

class SeguePresentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
