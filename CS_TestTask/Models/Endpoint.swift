//
//  Endpoint.swift
//  CS_TestTask
//
//  Created by Sasha Riabchuk on 30.01.2022.
//

import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "webapi.developers.erstegroup.com"
        components.path = "/api/csas/public/sandbox/" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
    
    static func getAccounts(page: Int) -> Self {
        Endpoint(
            path: "v3/transparentAccounts",
            queryItems: [
                URLQueryItem(name: "page", value: "\(page)"),
            ]
        )
    }
}
