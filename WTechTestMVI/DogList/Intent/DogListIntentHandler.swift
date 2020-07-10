//
//  IntentWorker.swift
//  WTechTestMVI
//
//  Created by Jae Kwang Lee on 2020/07/05.
//  Copyright © 2020 Jae Kwang Lee. All rights reserved.
//

import Foundation
import Combine

enum DogListSortType {
    case none
    case lifespan(isAscending: Bool)    
}


class DogListIntentHandler: ObservableObject, DogListIntentHandling {
    private(set) var action = PassthroughSubject<DogListAction, Never>()
    private let apiClient: DogAPIClient
    
    // States
    private var sortType: DogListSortType = .none
    private var items = [DogItem]()

    init(apiClient: DogAPIClient = DogAPIClient()) {
        self.apiClient = apiClient
    }
    
    // This is called from View
    func perform(_ intent: DogListIntent) {
        switch intent {
        case .viewAppeared:
            performViewAppeared()
        case .sort:
            performSort()
        }
    }
}

extension DogListIntentHandler {
    private func performViewAppeared() {
        action.send(.showLoading)
        
        apiClient.loadList(limit: 20) { [weak self] (response) in
            guard let self = self else { return }
            
            switch(response) {
            case .response(let entities):
                let items = entities.compactMap { (entity) -> DogItem? in
                    entity.dogItem
                }
                self.items = items
                self.action.send(.showItems(type: self.sortType, items: items))
            case .error(_):
                self.action.send(.error(message: "Cannot load items."))
            }
        }
    }

    private func performSort() {
        switch sortType {
        case .lifespan(let isAscending):
            let nextIsAscending = !isAscending
            sortType = .lifespan(isAscending: nextIsAscending)
        default:
            sortType = .lifespan(isAscending: true)
        }

        items = sortedItems(sort: sortType)
        self.action.send(.showItems(type: self.sortType, items: items))
    }
    
    private func sortedItems(sort: DogListSortType) -> [DogItem] {
        let sortedItems: [DogItem]
        switch sortType {
        case .lifespan(let isAscending):
            sortedItems = items.sorted { (lhs, rhs) -> Bool in
                if isAscending {
                    return lhs.lifeSpanAverage < rhs.lifeSpanAverage
                }
                else {
                    return lhs.lifeSpanAverage > rhs.lifeSpanAverage
                }
            }
        default:
            sortedItems = items
        }
        return sortedItems
    }
}
