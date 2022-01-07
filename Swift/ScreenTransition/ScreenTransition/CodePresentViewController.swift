//
//  CodePresentViewController.swift
//  ScreenTransition
//
//  Created by Bumsang Kim on 2021/12/21.
//

import UIKit

protocol SendDataDelegate: AnyObject {
    func sendData(name: String)
}

class CodePresentViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    var name:String?
    // delegate => Weak!! 강한 순환 참조에 의한 메모리 누수 발생
    weak var delegate: SendDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = name {
            self.nameLabel.text = name
            self.nameLabel.sizeToFit()
        }
     }
    @IBAction func tapBackButton(_ sender: UIButton) {
        self.delegate?.sendData(name: "bumsang")
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
