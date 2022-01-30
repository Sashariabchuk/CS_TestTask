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
        
        UIView.animate(withDuration: 1, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseIn, animations: ({ [self] in
            self.cardView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
            self.cardView.center = self.contentView.center

        }), completion: nil)
    }
    
}
