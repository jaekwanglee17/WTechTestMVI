//
//  DogListRowViewModel.swift
//  WTechTestMVI
//
//  Created by Jae Kwang Lee on 2020/07/05.
//  Copyright © 2020 Jae Kwang Lee. All rights reserved.
//

import Combine

class DogListRowViewModel: Identifiable {
    @Published private(set) var id: String
    @Published private(set) var name: String
    @Published private(set) var photoURL: String
    @Published private(set) var lifespanFormatted: String
    @Published private(set) var desc: String
    
    init(id: String,
         name: String,
         photoURL: String,
         lifespanFormatted: String,
         desc: String) {
        self.id = id
        self.name = name
        self.photoURL = photoURL
        self.lifespanFormatted = lifespanFormatted
        self.desc = desc
    }
    
}

