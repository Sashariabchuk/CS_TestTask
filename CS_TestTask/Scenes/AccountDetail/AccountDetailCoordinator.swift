//
//  AccountDetailCoordinator.swift
//  CS_TestTask
//
//  Created by Sasha Riabchuk on 29.01.2022.
//

import UIKit

protocol AccountDetailCoordinatorProtocol: Coordinator {
   func openDetail()
}

class AccountDetailCoordinator: AccountDetailCoordinatorProtocol {

    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .detail }
    
    var account: Accounts?
    var backgroundColor: UIColor?
    
    func start() {
        openDetail()
    }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func openDetail() {
        let storyboard = UIStoryboard(name: "AccountDetailStoryboard", bundle: .main)
        guard let accountDetailViewController = storyboard.instantiateViewController(withIdentifier: "AccountDetailViewController") as? AccountDetailViewController else { return }
        let accountDetailViewModel = AccountDetailViewModel()
        
        accountDetailViewModel.coordinator = self
        accountDetailViewController.viewModel = accountDetailViewModel
        accountDetailViewController.account = account
        accountDetailViewController.backgroundColor = backgroundColor
        accountDetailViewController.title = "Detail"
        
        navigationController.present(accountDetailViewController, animated: true)
    }
    
}
