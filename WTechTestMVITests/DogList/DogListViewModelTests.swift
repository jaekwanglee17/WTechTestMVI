//
//  DogListViewModelTests.swift
//  WTechTestMVITests
//
//  Created by Jae Kwang Lee on 2020/07/10.
//  Copyright © 2020 Jae Kwang Lee. All rights reserved.
//

import XCTest
import Combine
@testable import WTechTestMVI

class DogListViewModelTests: XCTestCase {
    
    var viewModel: DogListViewModel!
    var action = PassthroughSubject<DogListAction, Never>()
    
    override func setUpWithError() throws {
        viewModel = DogListViewModel()
        viewModel.subscribe(action: action)
    }
    
    func testShowLoadingActionChangesToLoading() throws {
        action.send(.showLoading)
        
        var isShowLoading: Bool = false
        
        switch(viewModel.state) {
        case .loading:
            isShowLoading = true
        default:
            XCTFail("Unexpected Behaviour")
        }

        XCTAssertTrue(isShowLoading)
    }
}

