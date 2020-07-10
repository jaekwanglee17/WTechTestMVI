//
//  DogListViewModel.swift
//  WTechTestMVI
//
//  Created by Jae Kwang Lee on 2020/07/05.
//  Copyright © 2020 Jae Kwang Lee. All rights reserved.
//

import Foundation
import Combine

enum DogListViewModelState: Equatable {
    case loading
    case list
    case failed
}

class DogListViewModel: ObservableObject {

    private var subscriber: AnyCancellable!

    @Published private(set) var state: DogListViewModelState = .loading
    @Published private(set) var sortText: String = "Sort"
    @Published private(set) var rowModels = [DogListRowViewModel]()
    @Published private(set) var errorMessage: String? = nil

    func subscribe(action: PassthroughSubject<DogListAction, Never>) {
        subscriber = action
            .sink(receiveValue: { [weak self] (action) in
                self?.reduce(action: action)
            })
    }
}

extension DogListViewModel {
    private func reduce(action: DogListAction) {
        switch(action) {
        case .showLoading:
            state = .loading
        case .showItems(let sortType, let items):
            state = .list
            sortText = sortType.text
            rowModels = items.compactMap({ (item) -> DogListRowViewModel? in
                DogListRowViewModel(id: item.id, name: item.name, photoURL: item.photoURL, lifespanFormatted: item.lifespanFormatted, desc: item.temperaments.joined(separator: ", "))
            })
        case .error(let errorMessage):
            state = .failed
            self.errorMessage = errorMessage
        }
    }
}

private extension DogListSortType {
    var text: String {
        switch self {
        case .none:
            return "Sort"
        case .lifespan(let isAscending):
            let arrowText = isAscending ? "▲" : "▼"
            return "Life Span \(arrowText)"
        }
    }
}
