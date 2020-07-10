//
//  DogListProtocols.swift
//  WTechTestMVI
//
//  Created by Jae Kwang Lee on 2020/07/10.
//  Copyright © 2020 Jae Kwang Lee. All rights reserved.
//

import Combine

protocol DogListIntentHandling {
    func perform(_ intent: DogListIntent)
}


protocol DogListActionSubscribing {
    func subscribe(action: PassthroughSubject<DogListAction, Never>)
}
