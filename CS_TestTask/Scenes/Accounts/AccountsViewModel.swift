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
    func stopActivityIndicator()
    func startActiviryIndicator()
}

class AccountsViewModel {
    
    var delegate: AccountsProtocol?
    var coordinator: AccountsCoordinator?
    
    var accounts = [Accounts]()
    var currentPage = 0
    
    init() {
        accounts.removeAll()
        getAccounts()
    }
    
    func getAccounts() {
        //start activity indicatore
        delegate?.startActiviryIndicator()
        guard let urlRequest = NetworkService.shared.getURLRequest(for: Endpoint.getAccounts(page: currentPage).url) else { return }
        NetworkService.shared.fetchData(urlRequest: urlRequest) { (result: Result<AccountsList, Error>) in
            switch result {
                case .success(let data):
                    self.currentPage += 1
                    self.accounts.append(contentsOf: data.accounts)
                    self.delegate?.reload(with: self.accounts)
                    self.delegate?.stopActivityIndicator()
                case .failure(let error):
                    self.delegate?.stopActivityIndicator()
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
