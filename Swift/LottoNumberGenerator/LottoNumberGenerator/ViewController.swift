//
//  ViewController.swift
//  LottoNumberGenerator
//
//  Created by Bumsang Kim on 2021/12/15.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var lottoNumber1: UILabel!
    @IBOutlet weak var lottoNumber2: UILabel!
    @IBOutlet weak var lottoNumber3: UILabel!
    @IBOutlet weak var lottoNumber4: UILabel!
    @IBOutlet weak var lottoNumber5: UILabel!
    @IBOutlet weak var lottoNumber6: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func generateLottoNumbers(_ sender: Any) {
        var random:[Int] = [Int]()
        
        for _ in 0..<6 {
            random.append(Int(arc4random_uniform(44)))
        }
        
        for i in 0..<6 {
            for j in 0..<i {
                if random[i] == random[j] {
                    while 1 == 1{
                        random[i] = Int(arc4random_uniform(44))
                        var isUsingNumber = false
                        for k in 0..<i{
                            if random[i] == random[k] {
                                isUsingNumber = true
                                break
                            }
                        }
                        if isUsingNumber == false {
                            break
                        }
                    }
                    
                }
            }
        }
        
        random.sort()
        
        self.lottoNumber1.text = String(random[0]+1)
        self.lottoNumber2.text = String(random[1]+1)
        self.lottoNumber3.text = String(random[2]+1)
        self.lottoNumber4.text = String(random[3]+1)
        self.lottoNumber5.text = String(random[4]+1)
        self.lottoNumber6.text = String(random[5]+1)
    }
    
}

