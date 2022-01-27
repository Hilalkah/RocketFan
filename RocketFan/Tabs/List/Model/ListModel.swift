//
//  ListModel.swift
//  RocketFan
//
//  Created by Hilal on 13.01.2022.
//

import Foundation

struct ListModel: Codable {
    let id: String
    let active: Bool
    let name: String
    let description: String
    let flickrImages: [String]
    
    private enum CodingKeys: String, CodingKey {
        case id, active, name, description, flickrImages = "flickr_images"
    }
    
}
