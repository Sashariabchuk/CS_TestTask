//
//  AccountsListViewController.swift
//  CS_TestTask
//
//  Created by Sasha Riabchuk on 30.01.2022.
//

import UIKit

class AccountsListViewController: UIViewController, AccountsProtocol {
    
    @IBOutlet weak var tableView: UITableView!

    var viewModel: AccountsViewModel?
    private var accounts = [Accounts]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func reload(with accounts: [Accounts]) {
        DispatchQueue.global().async {
            self.accounts = accounts
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension AccountsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "accountsListCell") as? AccountsListTableViewCell else { return UITableViewCell()}
        
        cell.nameLabel.text = accounts[indexPath.row].name
        cell.accountNumberLabel.text = accounts[indexPath.row].accountNumber
        
        return cell
    }
}

extension AccountsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.showDetail(of: accounts[indexPath.row])
    }
}

