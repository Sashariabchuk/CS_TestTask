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
            
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                print("error", error ?? "Unknown error")
                completion(.failure(error as! Error))
                return
            }
            
//            guard (400 ... 500) ~= response.statusCode else {
//                print("statusCode should be 2xx, but is \(response.statusCode)")
//                print("response = \(response)")
//                return
//            }
            
            do {

                let decoder = JSONDecoder()
                let data = try decoder.decode(T.self, from: data)
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getURLRequest(from path: String) -> URLRequest? {
        guard let url = URL(string: path) else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        

        urlRequest.setValue(Constants.API_KEY, forHTTPHeaderField: "WEB-API-key")
        
        
        return urlRequest
    }
}
