//
//  NetworkManager.swift
//  RocketFan
//
//  Created by Hilal on 29.01.2022.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func fetchData<T: Decodable>(requestUrl: URL,
                                 model: T.Type,
                                 completion: @escaping ((T?, Error?) -> Void)) {
        
        let task = URLSession.shared.dataTask(with: requestUrl) { data, _, _ in
            guard let data = data else { return }
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(model, nil)
            } catch {
                completion(nil, error)
            }
        }
        
        task.resume()
    }
    
}
