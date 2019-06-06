//
//  Router.swift
//  ArmyOfOnes
//
//  Created by David Figueroa on 6/5/19.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import Foundation
import Alamofire

enum API : Router {
    case getExchangeRate(parameters: [String: Any])
    
    var query: APIQuery {
        switch(self) {
        case .getExchangeRate(let parameters):
            return APIQuery(httpMethod: .get, path: "latest", parameters: parameters)
        }
    }
    
}

struct APIQuery {
    
    var headers: [String: String]?
    var httpMethod: Alamofire.HTTPMethod
    var path: String
    var parameters: [String: Any]?
    
    var paremeterEncoding: Alamofire.ParameterEncoding = URLEncoding.default
    var cachePolicy: String = ""
    
    init(httpMethod: Alamofire.HTTPMethod, path: String) {
        self.httpMethod = httpMethod
        self.path = path
    }
    
    init(httpMethod: Alamofire.HTTPMethod, path: String, parameters: [String: Any]?) {
        self.httpMethod = httpMethod
        self.path = path
        self.parameters = parameters
    }
}

protocol Router: URLRequestConvertible {
    var query: APIQuery { get }
}

extension Router {
    
    //MARK: - URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: "https://api.exchangeratesapi.io/")
        var urlRequest = URLRequest(url: url!.appendingPathComponent(query.path))
        urlRequest.httpMethod = query.httpMethod.rawValue
        let encoding = query.paremeterEncoding
        print ("\(query.httpMethod.rawValue) \(try encoding.encode(urlRequest, with: query.parameters))")
        return try encoding.encode(urlRequest, with: query.parameters)
    }
    
}
