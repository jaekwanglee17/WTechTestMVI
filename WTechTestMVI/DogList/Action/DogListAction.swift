//
//  Actions.swift
//  WTechTestMVI
//
//  Created by Jae Kwang Lee on 2020/07/05.
//  Copyright © 2020 Jae Kwang Lee. All rights reserved.
//

import Foundation

enum DogListAction {
    case showLoading
    case showItems(type: DogListSortType, items: [DogItem])
    case error(message: String)
}
