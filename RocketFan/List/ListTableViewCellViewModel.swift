//
//  ListTableViewCellViewModel.swift
//  RocketFan
//
//  Created by Hilal on 13.01.2022.
//

import Foundation

struct ListTableViewCellViewModel {
    let id: String
    let name: String
    let description: String
    let flickr_images: [String]
    var isFavorite: Bool = false
}
