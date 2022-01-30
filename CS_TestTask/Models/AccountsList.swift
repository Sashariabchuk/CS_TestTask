//
//  AccountsList.swift
//  CS_TestTask
//
//  Created by Sasha Riabchuk on 29.01.2022.
//

import Foundation

struct AccountsList: Codable {
    let pageNumber: Int
    let pageSize: Int
    let pageCount: Int
    let nextPage: Int
    let recordCount: Int
    let accounts: [Accounts]
}
