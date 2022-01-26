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
    let flickr_images: [String]
}
