//
//  TableViewCell.swift
//  ToDoList
//
//  Created by Bumsang Kim on 2022/01/15.
//

import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userProfileImage: UIImageView!
    
    @IBOutlet weak var userContentLabel: UILabel!
    
    // it calls when rendering cell
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userProfileImage.layer.cornerRadius = userProfileImage.frame.height / 2
        
    }
}
