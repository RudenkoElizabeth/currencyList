//
//  ResponseClass.swift
//  currencyList
//
//  Created by Elizabeth Rudenko on 11.04.2018.
//  Copyright © 2018 Elizabeth Rudenko. All rights reserved.
//

import Foundation
import Moya

public enum ResponseClass {
    case informational
    case success
    case redirection
    case clientError
    case serverError
    case undefined
    
    public init(statusCode: Int) {
        switch statusCode {
        case 100 ..< 200:
            self = .informational
        case 200 ..< 300:
            self = .success
        case 300 ..< 400:
            self = .redirection
        case 400 ..< 500:
            self = .clientError
        case 500 ..< 600:
            self = .serverError
        default:
            self = .undefined
        }
    }
}

public extension Response {
    public var responseClass: ResponseClass {
        return ResponseClass(statusCode: self.statusCode)
    }
}
