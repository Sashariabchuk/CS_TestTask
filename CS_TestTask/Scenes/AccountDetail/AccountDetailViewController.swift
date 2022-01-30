//
//  AccountDetailViewController.swift
//  CS_TestTask
//
//  Created by Sasha Riabchuk on 29.01.2022.
//

import UIKit

class AccountDetailViewController: UIViewController {
    
    var viewModel: AccountDetailViewModel?
    
    var account: Accounts?
    
    var backgroundColor: UIColor?
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var accountHolderLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var accountCodeLabel: UILabel!
    @IBOutlet weak var ibanLabel: UILabel!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 25
        containerView.backgroundColor = backgroundColor
        containerView.dropShadow()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        accountHolderLabel.text = account?.name
        accountNumberLabel.text = account?.accountNumber
        accountCodeLabel.text = account?.bankCode
        ibanLabel.text = account?.iban
    }

}
