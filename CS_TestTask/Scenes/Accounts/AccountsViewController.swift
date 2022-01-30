//
//  AccountsViewController.swift
//  CS_TestTask
//
//  Created by Sasha Riabchuk on 29.01.2022.
//

import UIKit

class AccountsViewController: UIViewController, AccountsProtocol {
    
    var viewModel: AccountsViewModel?
    private var accounts = [Accounts]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var balanceView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        setUpNavigationBar()
        setUpBalanceView()
        setUpCollectionView()
    }
    
    // Setup NavigationBar with custom button which open list view.
    private func setUpNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .done, target: self, action: #selector(openList))
        navigationController?.navigationBar.tintColor = UIColor(named: "PurpleForeground")
    }
    
    // Setup BalanceView
    private func setUpBalanceView() {
        balanceView.layer.masksToBounds = true
        balanceView.layer.cornerRadius = 20
        balanceView.dropShadow()
    }
    
    // Setup collectionView with own ViewLayout for single cell pagination.
    private func setUpCollectionView() {
        collectionView.register(UINib(nibName: "AccountCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "accountCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Layer modification
        collectionView.layer.masksToBounds = true
        collectionView.layer.cornerRadius = 20
        
        let layout = PagingCollectionViewLayout()
        layout.itemSize = CGSize(width: view.bounds.width, height: collectionView.bounds.height)
        layout.numberOfItemsPerPage = 1
        layout.scrollDirection = .horizontal
        
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.isPagingEnabled = false
        collectionView.decelerationRate = .fast
    }
    
    @objc func openList(_ sender: UIButton) {
        viewModel?.showList()
    }
    
    // Delegates methods
    func reload(with accounts: [Accounts]) {
        DispatchQueue.global().async {
            self.accounts = accounts
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension AccountsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "accountCell", for: indexPath) as? AccountCollectionViewCell else { return UICollectionViewCell.init() }
        
        cell.balanceLabel.text = "\(accounts[indexPath.row].balance)"
        cell.accountNumberLabel.text = accounts[indexPath.row].accountNumber
        cell.bankCodeLabel.text = accounts[indexPath.row].bankCode
        cell.cardView.backgroundColor = .random
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension AccountsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = self.collectionView.cellForItem(at: indexPath) as? AccountCollectionViewCell
        guard let backgroundColor = cell?.cardView.backgroundColor else { return }
        viewModel?.showDetail(of: accounts[indexPath.row], backgroundColor: backgroundColor)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        nameLabel.text = accounts[indexPath.row].name
        balanceLabel.text = "\(accounts[indexPath.row].balance)"
        currencyLabel.text = accounts[indexPath.row].currency ?? ""
    }
}
