//
//  DogAPIRouter.swift
//  WTechTestMVI
//
//  Created by Jae Kwang Lee on 2020/02/21.
//  Copyright © 2020 Jae Kwang Lee. All rights reserved.
//

import Foundation
import Alamofire

enum DogAPIRouter: URLRequestConvertible {
    
    static let baseURLString = APIConstant.BaseDogAPIPath
    
    case loadList(limit: Int = 50)

    var method: HTTPMethod {
        switch self {
        case .loadList:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .loadList(_):
            return "/v1/images/search"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let urlRequest: URLRequest = try self.getUrlRequest(baseUrl: DogAPIRouter.baseURLString, path: path, method: method)
        var parameterDic: Dictionary<String, Any>  = [:]
        
        switch self {
        case .loadList(let limit):
            parameterDic = [ "limit" : limit
            ]
        }

        let encodedURLRequest = try URLEncoding.queryString.encode(urlRequest, with: parameterDic)
        return encodedURLRequest
    }
    
    private func getUrlRequest(baseUrl: String, path: String, method: HTTPMethod) throws -> URLRequest {
        
        let url = try baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return urlRequest
    }
}
