//
//  ViewController.swift
//  QuotesGenerator
//
//  Created by Bumsang Kim on 2021/12/14.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var qoutoLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    let quotes = [
        Quote(contents: "나는 나다!", name: "밤송이"),
        Quote(contents: "아니야 이 망충이!", name: "아로미"),
        Quote(contents: "편견이란 실효성이 없는 의견이다.", name: "암브로스 빌"),
        Quote(contents: "분노는 바보들의 가슴속에서만 살아간다.", name: "아인슈타인")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapQouteGeneratorButton(_ sender: Any) {
        // Random
        let random = Int(arc4random_uniform(4))
        let quote = quotes[random]
        self.qoutoLabel.text = quote.contents
        self.nameLabel.text = quote.name
        
    }
    
}

