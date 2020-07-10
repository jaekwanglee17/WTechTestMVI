//
//  DogModel.swift
//  WTechTestMVI
//
//  Created by Jae Kwang Lee on 2020/07/06.
//  Copyright © 2020 Jae Kwang Lee. All rights reserved.
//

import Foundation

struct DogItem {
    let id: String
    let name: String
    let countryCode: String?
    let bredFor: String
    let lifespanFormatted: String
    let temperaments: [String]
    let photoURL: String
    let lifespanMin: Int
    let lifespanMax: Int

    var lifeSpanAverage: Int {
        get {
            return (lifespanMin + lifespanMax) / 2
        }
    }
}

extension DogItem {
    static func parseLifeSpan(lifeSpanFormatted: String) -> (Int, Int)? {
        var lifeSpanMin: Int?
        var lifeSpanMax: Int?
        
        guard String(lifeSpanFormatted.suffix(5)) == "years" else { return nil }
        
        let trimmed = lifeSpanFormatted.dropLast(5).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let tokens = trimmed.split(separator: "-")
        
        guard tokens.count == 2 else { return nil }
                
        lifeSpanMin = Int(tokens[0].trimmingCharacters(in: CharacterSet.whitespaces))
        lifeSpanMax = Int(tokens[1].trimmingCharacters(in: CharacterSet.whitespaces))
        
        guard let min = lifeSpanMin, let max = lifeSpanMax else { return nil }

        return (min, max)
    }
    
    fileprivate func getSorted(dogs: [DogItem], sortBy: DogListSortType) -> [DogItem] {
        let sortedDogs: [DogItem]
        switch(sortBy) {
        case .lifespan(let isAscending):
            if isAscending {
                sortedDogs = dogs.sorted { (lhs, rhs) -> Bool in
                    lhs.lifeSpanAverage < rhs.lifeSpanAverage
                }
            }
            else {
                sortedDogs = dogs.sorted { (lhs, rhs) -> Bool in
                    lhs.lifeSpanAverage > rhs.lifeSpanAverage
                }
            }
            default:
                sortedDogs = dogs
        }
        return sortedDogs
    }
}

extension DogData {
    var dogItem: DogItem? {
        guard let firstBreed = breeds?.first else { return nil }
        guard let id = id,
            let name = firstBreed.name,
            let bredFor = firstBreed.bred_for,
            let lifespanFormatted = firstBreed.life_span,
            let temperamentString = firstBreed.temperament,
            let photoURL = url
            else {
                return nil
        }
        
        let countryCode = firstBreed.country_code

        let lifespanMin: Int, lifespanMax: Int
        guard let tuple = DogItem.parseLifeSpan(lifeSpanFormatted: lifespanFormatted) else { return nil }
        (lifespanMin, lifespanMax) = tuple

        // Todo: Make it as enumeration.
        let temperaments = Array(temperamentString.split(separator: ",")).map({
            return $0.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        })

        return DogItem(id: id, name: name, countryCode: countryCode, bredFor: bredFor, lifespanFormatted: lifespanFormatted, temperaments: temperaments, photoURL: photoURL, lifespanMin: lifespanMin, lifespanMax: lifespanMax)
    }
}

