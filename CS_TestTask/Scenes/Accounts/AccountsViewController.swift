//
//  AccountsViewController.swift
//  CS_TestTask
//
//  Created by Sasha Riabchuk on 29.01.2022.
//

import UIKit

class AccountsViewController: UIViewController {
    
    var viewModel: AccountsViewModel?
    
    //MARK: - CollectionView
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Components outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var transparencyFrom: UILabel!
    @IBOutlet weak var transparencyTo: UILabel!
    @IBOutlet weak var ibanLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
    }
    
    private func setUpCollectionView() {
        collectionView.register(UINib(nibName: "AccountCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "accountCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.layer.masksToBounds = true
        collectionView.layer.cornerRadius = 30
        
        let layout = PagingCollectionViewLayout()
        layout.itemSize = CGSize(width: collectionView.bounds.width - 50, height: collectionView.bounds.height - 200)
        layout.scrollDirection = .horizontal

        collectionView.setCollectionViewLayout(layout, animated: true)
        
        collectionView.isPagingEnabled = false
        collectionView.decelerationRate = .normal
    }
}

extension AccountsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "accountCell", for: indexPath) as? AccountCollectionViewCell else { return UICollectionViewCell.init() }
        
        cell.balanceLabel.text = "2 000 CZK"
        cell.accountNumberLabel.text = "000000-0109213309"
        cell.bankCodeLabel.text = "0800"
        
        nameLabel.text = "Společenství Praha 4, Obětí 6.května 553"
        balanceLabel.text = "2 000 CZK"
        transparencyFrom.text = "12.4.2012"
        transparencyTo.text = "31.4.2072"
        ibanLabel.text = "CZ75 0800 0000 0001 0921 3309"
        
        cell.cardView.backgroundColor = .random
        
        return cell
    }
    
}

extension AccountsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    }

}

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1), alpha: 1
        )
    }
}
