//
//  CovidDetailViewController.swift
//  COVID19-현황
//
//  Created by Bumsang Kim on 2022/01/28.
//

import UIKit

class CovidDetailViewController: UITableViewController {

    @IBOutlet weak var newCaseCell: UITableViewCell!
    @IBOutlet weak var totalCaseCell: UITableViewCell!
    @IBOutlet weak var recoveredCell: UIView!
    @IBOutlet weak var deathCell: UITableViewCell!
    @IBOutlet weak var occurePercentageCell: UITableViewCell!
    @IBOutlet weak var overseaInflowCell: UITableViewCell!
    @IBOutlet weak var regionOutbreakCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
