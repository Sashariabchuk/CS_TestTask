//
//  AppCoordinator.swift
//  CS_TestTask
//
//  Created by Sasha Riabchuk on 28.01.2022.
//

import UIKit

// Appcoordinator flow
protocol AppCoordinatorProtocol: Coordinator {
    func showAccountsFlow()
}

class AppCoordinator: AppCoordinatorProtocol {

    weak var finishDelegate: CoordinatorFinishDelegate? = nil
    
    var navigationController: UINavigationController
    
    var childCoordinators = [Coordinator]()
    
    var type: CoordinatorType { .app }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    func start() {
        showAccountsFlow()
    }
    
    
    func showAccountsFlow() {
        let accountsCoordinator = AccountsCoordinator(navigationController)
        accountsCoordinator.start()
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })
    }
}
