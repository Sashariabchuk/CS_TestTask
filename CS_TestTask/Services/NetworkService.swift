//
//  APIService.swift
//  CS_TestTask
//
//  Created by Sasha Riabchuk on 29.01.2022.
//

import Foundation

class NetworkService {
    
    static var shared = NetworkService()
    
    func fetchData<T: Codable>(urlRequest: URLRequest, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data, let _ = response as? HTTPURLResponse, error == nil else {
                print("error", error ?? "Unknown error")
                completion(.failure(error as! Error))
                return
            }
            do {
                
                let decoder = JSONDecoder()
                let data = try decoder.decode(T.self, from: data)
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getURLRequest(for url: URL) -> URLRequest? {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(Constants.API_KEY, forHTTPHeaderField: "WEB-API-key")
        return urlRequest
    }
}
