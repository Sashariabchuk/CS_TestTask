//
//  MainCoordinator.swift
//  CS_TestTask
//
//  Created by Sasha Riabchuk on 29.01.2022.
//

import UIKit

protocol AccountsCoordinatorProtocol: Coordinator {
    func showAccountsVC()
    func navigateToDetailPage(for account: Accounts, backgroundColor: UIColor)
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
        
        accountsViewModel.coordinator = self
        accountsViewController.viewModel = accountsViewModel
        accountsViewController.title = "Accounts"
        
        navigationController.pushViewController(accountsViewController, animated: true)
    }
    
    // Navigate to detail page
    func navigateToDetailPage(for account: Accounts, backgroundColor: UIColor) {
        let accountDetailCoordinator = AccountDetailCoordinator(navigationController)
        accountDetailCoordinator.account = account
        accountDetailCoordinator.backgroundColor = backgroundColor
        childCoordinators.append(accountDetailCoordinator)
        accountDetailCoordinator.start()
    }
    
    func showList() {
        let storyboard = UIStoryboard(name: "AccountsListStoryboard", bundle: .main)
        guard let accountsListViewController = storyboard.instantiateViewController(withIdentifier: "AccountsListViewController") as? AccountsListViewController else { return }
        let accountsViewModel = AccountsViewModel()
        
        accountsViewModel.coordinator = self
        accountsListViewController.viewModel = accountsViewModel
        accountsListViewController.title = "Accounts list"
        
        navigationController.pushViewController(accountsListViewController, animated: true)
    }
}
