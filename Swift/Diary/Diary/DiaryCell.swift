//
//  DiaryCell.swift
//  Diary
//
//  Created by Bumsang Kim on 2022/01/18.
//

import UIKit

class DiaryCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        var borderColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 255/255)
        if traitCollection.userInterfaceStyle == .dark {
            borderColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 255/255)
        }
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = borderColor.cgColor
    }
}
