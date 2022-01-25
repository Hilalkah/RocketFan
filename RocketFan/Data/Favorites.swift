//
//  Favorites.swift
//  RocketFan
//
//  Created by Hilal on 19.01.2022.
//

import Foundation

class Favorites {
    
    static let shared = Favorites()
    
    private let keyValue = "Favorites"
    
    var items: [String] {
        set {
            UserDefaults.standard.set(newValue, forKey: keyValue)
            UserDefaults.standard.synchronize()
        }
        get {
            return (UserDefaults.standard.array(forKey: keyValue) as? [String]) ?? []
        }
    }
    
    func addItem(_ id: String) {
        items.append(id)
    }
    
    func removeItem(_ id: String) {
        guard let index: Int = items.firstIndex(of: id) else { return }
        items.remove(at: index)
    }
    
}
