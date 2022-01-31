//
//  RocketManager.swift
//  RocketFan
//
//  Created by Hilal on 31.01.2022.
//

import Foundation

class RocketManager {
    
    private static var sharedInstance: RocketManager?
    
    static func getInstance() -> RocketManager {
        if sharedInstance == nil {
            sharedInstance = RocketManager()
        }
        return sharedInstance!
    }
    
    private func getRocketsRequest() -> URL? {
        return URL(string: "https://api.spacexdata.com/v4/rockets")
    }
    
    func fetchData(completion: @escaping (([ListModel]?, Error?) -> Void)) {
        guard let requestUrl = getRocketsRequest() else { return }
        
        NetworkManager.shared.fetchData(requestUrl: requestUrl,
                                        model: [ListModel].self,
                                        completion: { model, error in
            if error != nil {
                completion(nil, error)
                return
            }
            
            guard let reponseModel = model else {
                completion(nil, nil)
                return
            }
            
            completion(reponseModel, nil)
            
        })
    }
    
}
