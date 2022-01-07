//
//  ViewController.swift
//  ScreenTransition
//
//  Created by Bumsang Kim on 2021/12/20.
//

import UIKit

class ViewController: UIViewController, SendDataDelegate {
    
    @IBOutlet weak var name: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController 뷰가 로드 되었다.")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewController 뷰가 나타날 것이다.")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ViewController 뷰가 나타났다.")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ViewController 뷰가 사라질 것이다.")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ViewController 뷰가 사라졌다.")
    }

    @IBAction func tapCodePushButton(_ sender: UIButton) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "CodePushViewController") as? CodePushViewController else { return }
        viewController.modalPresentationStyle = .fullScreen
        viewController.name = "범상이이잉"
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    @IBAction func tapCodePresentButton(_ sender: UIButton) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "CodePresentViewController") as? CodePresentViewController else { return }
        viewController.modalPresentationStyle = .fullScreen
        viewController.name = "애로미이이이잉"
        viewController.delegate = self
        self.present(viewController, animated: true, completion: nil)
    }
    
    // prepare override시 segueway 호출시 자동으로 이 메서드가 호출됨!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //전환하려는 segueway의 인스턴스를 가져온다.
        if let viewController = segue.destination as? SeguePushViewController {
            viewController.name = "prepare aaaahreum!!"
        }
    }
    func sendData(name: String) {
        self.name.text = name
        self.name.sizeToFit()
    }
}

