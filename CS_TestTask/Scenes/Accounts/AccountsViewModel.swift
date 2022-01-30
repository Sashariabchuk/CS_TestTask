//
//  AccountsViewModel.swift
//  CS_TestTask
//
//  Created by Sasha Riabchuk on 29.01.2022.
//

import Foundation
import UIKit

protocol AccountsProtocol {
    func reload(with accounts: [Accounts])
}

class AccountsViewModel {
    
    var delegate: AccountsProtocol?
    var coordinator: AccountsCoordinator?
    
    var accounts = [Accounts]()
    
    init() {
        accounts.removeAll()
        getAccounts()
    }
    
    func getAccounts() {
        guard let urlRequest = NetworkService.shared.getURLRequest(from: Constants.API_URL) else { return }
        NetworkService.shared.fetchData(urlRequest: urlRequest) { (result: Result<AccountsList, Error>) in
            switch result {
                case .success(let data):
                    self.accounts.append(contentsOf: data.accounts)
                    self.delegate?.reload(with: self.accounts)
                case .failure(let error):
                    print(error)
 
            }
        }
    }
    
    func showDetail(of account: Accounts, backgroundColor: UIColor = .random) {
        coordinator?.navigateToDetailPage(for: account, backgroundColor: backgroundColor )
    }
    
    func showList() {
        coordinator?.showList()
    }
    
}
