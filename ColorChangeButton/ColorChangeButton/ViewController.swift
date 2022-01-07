//
//  ViewController.swift
//  ColorChangeButton
//
//  Created by Bumsang Kim on 2021/12/08.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapChangeColorButton(_ sender: UIButton) {
        
        self.colorView.backgroundColor = UIColor.blue
        print("색상 변경 버튼이 클릭 되었습니다.")
    }
    
}

