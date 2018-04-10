//
//  ApiEndpoint.swift
//  currencyList
//
//  Created by Elizabeth Rudenko on 11.04.2018.
//  Copyright © 2018 Elizabeth Rudenko. All rights reserved.
//

import Foundation
import Moya

enum ApiEndpoint {
    case getTransaction()
}

extension ApiEndpoint: TargetType {
    var headers: [String : String]? {
        return nil
    }

    //path of requests
    var baseURL: URL { return URL(string: "http://phisix-api3.appspot.com/")! }
    
    var path: String {
        return "stocks.json"
    }
    
    //include parameters
    var task: Task {
        return .requestPlain
    }
    
    //choose type of request
    var method: Moya.Method {
        return .get
    }
    
    //for tests
    var sampleData: Data {
        return Data.init()
    }
    
    //params encoding type
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
}
