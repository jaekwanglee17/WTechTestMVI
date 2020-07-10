//
//  DogListIntentHandlerTest.swift
//  WTechTestMVITests
//
//  Created by Jae Kwang Lee on 2020/07/10.
//  Copyright © 2020 Jae Kwang Lee. All rights reserved.
//

import XCTest
import Combine
@testable import WTechTestMVI


class DogListIntentHandlerTest: XCTestCase {

    var intentHandler: DogListIntentHandler!
    var subscriber: MockSubscriber!

    override func setUpWithError() throws {
        // Todo: Add mock API clients for other tests
        intentHandler = DogListIntentHandler()
        subscriber = MockSubscriber()
        subscriber.subscribe(action: intentHandler.action)
    }

    func testViewAppearedCallsLoading() throws {
        var isShowLoading: Bool = false
        
        intentHandler.perform(.viewAppeared)
        
        switch (subscriber.actionCalled) {
        case .showLoading:
            isShowLoading = true
        default:
            ()
            // Todo
        }
        XCTAssertTrue(isShowLoading)
    }
}

class MockSubscriber: DogListActionSubscribing {
    var actionCalled: DogListAction = .showLoading
    var subscriber: AnyCancellable!

    func subscribe(action: PassthroughSubject<DogListAction, Never>) {
        subscriber = action.sink { (acitonType) in
            self.actionCalled = acitonType
        }
    }
}
