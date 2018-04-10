//
//  ResponceModel.swift
//  currencyList
//
//  Created by Elizabeth Rudenko on 10.04.2018.
//  Copyright © 2018 Elizabeth Rudenko. All rights reserved.
//

import Foundation

struct ResponseModel: Decodable {
    let stock: [CurrencyModel]?
}

struct CurrencyModel: Decodable {
    let name: String?
    let volume: Int?
    let price: PriceModel?
}

struct PriceModel: Decodable {
    let amount: Double?
}
