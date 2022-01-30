//
//  AccountCollectionViewCell.swift
//  CS_TestTask
//
//  Created by Sasha Riabchuk on 29.01.2022.
//

import UIKit

class AccountCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var balanceTitleLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var bankCodeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        balanceTitleLabel.text = "Balance"
        cardView.layer.masksToBounds = true
        cardView.layer.cornerRadius = 25
        cardView.dropShadow()
    }
}
