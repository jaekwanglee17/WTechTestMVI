//
//  DogEntity.swift
//  WTechTestMVI
//
//  Created by Jae Kwang Lee on 2020/07/05.
//  Copyright © 2020 Jae Kwang Lee. All rights reserved.
//

import Foundation

struct DogMeasurement: Codable {
    let imperial: String?
    let metric: String?
}

struct DogBreed: Codable {
    let weight: DogMeasurement?
    let height: DogMeasurement?
    let id: Int?
    let name: String?
    let country_code: String?
    let bred_for: String?
    let bred_group: String?
    let life_span: String?
    let temperament: String?
}

struct DogData: Codable {
    var id: String?
    var url: String?
    var width: Int?
    var height: Int?
    var breeds: [DogBreed]?
}

