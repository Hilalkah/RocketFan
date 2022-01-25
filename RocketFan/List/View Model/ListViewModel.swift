//
//  ListViewModel.swift
//  RocketFan
//
//  Created by Hilal on 13.01.2022.
//

import Foundation

struct ListViewModel {
    var list: Observable<[ListTableViewCellViewModel]> = Observable([])
}
