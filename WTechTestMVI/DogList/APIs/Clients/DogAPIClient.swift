//
//  DogAPIClient.swift
//  WTechTestMVI
//
//  Created by Jae Kwang Lee on 2020/02/21.
//  Copyright © 2020 Jae Kwang Lee. All rights reserved.
//

import Foundation
import Alamofire

enum DogAPIClientResponse {
    case response([DogData])
    case error(DogAPIClientError)
}

enum DogAPIClientError: Error {
    case noResponse
    case notValidFormat
}
extension DogAPIClientError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noResponse:
            return NSLocalizedString("Cannot load data. Please check the network again.", comment: "noResponse")
        case .notValidFormat:
            return NSLocalizedString("Cannot load data. Please contact the customer service.", comment: "notValidFormat")
        }
    }
}

class DogAPIClient {
    let baseURLString: String
    
    class func sharedInstance() -> DogAPIClient {
        struct __ { static let _sharedInstance = DogAPIClient() }
        return __._sharedInstance
    }
    
    init() {
        self.baseURLString = APIConstant.BaseDogAPIPath
    }
    
    func loadList(limit: Int = 50, completion:((DogAPIClientResponse) -> Void)?) {
        Alamofire.request(DogAPIRouter.loadList(limit: limit))
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                
                switch response.result {
                case .success(let result):
                    guard let resultDic = result as? [Dictionary<String, Any>] else {
                        completion?(DogAPIClientResponse.error(.notValidFormat))
                        return
                    }
                    
                    let decoder = DictionaryDecoder()
                    guard let dogs = try? decoder.decode([DogData].self, from: resultDic as Any) else {
                        completion?(DogAPIClientResponse.error(.notValidFormat))
                        return
                    }

                    completion?(DogAPIClientResponse.response(dogs))
                case .failure(_):
                    completion?(DogAPIClientResponse.error(.noResponse))
                }
        }
    }
    
}
