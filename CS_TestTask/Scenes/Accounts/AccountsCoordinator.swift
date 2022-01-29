//
//  MainCoordinator.swift
//  CS_TestTask
//
//  Created by Sasha Riabchuk on 29.01.2022.
//

import UIKit

protocol AccountsCoordinatorProtocol: Coordinator {
    func showAccountsVC()
}

class AccountsCoordinator: AccountsCoordinatorProtocol {

    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .accounts }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showAccountsVC()
    }
    
    func showAccountsVC() {
        let storyboard = UIStoryboard(name: "AccountsStoryboard", bundle: .main)
        guard let accountsViewController = storyboard.instantiateViewController(withIdentifier: "AccountsViewController") as? AccountsViewController else { return }
        let accountsViewModel = AccountsViewModel()
        
//        previewViewModel.coordinator = self
        
        accountsViewController.viewModel = accountsViewModel
        
        accountsViewController.title = "Accounts"
        
        navigationController.pushViewController(accountsViewController, animated: true)
    }

}
