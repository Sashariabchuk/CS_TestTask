//
//  Accounts.swift
//  CS_TestTask
//
//  Created by Sasha Riabchuk on 29.01.2022.
//

import Foundation

struct Accounts: Codable {
    let accountNumber: String
    let bankCode: String
    let transparencyFrom: String
    let transparencyTo: String
    let publicationTo: String
    let actualizationDate: String
    let balance: Double
    let currency: String?
    let name: String
    let iban: String
}
