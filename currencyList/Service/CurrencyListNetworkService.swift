//
//  Service.swift
//  currencyList
//
//  Created by Elizabeth Rudenko on 10.04.2018.
//  Copyright © 2018 Elizabeth Rudenko. All rights reserved.
//

import Foundation
import Moya

protocol CurrencyListDelegate: class {
    func succeessTransaction(_ array: [CurrencyModel])
    func errorTransaction(_ errorText: String)
}

class CurrencyListNetworkService: NSObject {
    
    weak var delegate: CurrencyListDelegate?
    let text = "Something went wrong\nTry again later"
    
    func getList() {
        let apiProvider = MoyaProvider<ApiEndpoint>()
        
        apiProvider.request(ApiEndpoint.getTransaction()) { (result) in
            switch result {
            case let .success(response):
                switch response.responseClass {
                case .success:
                    self.mapTransactionList(response: response)
                default:
                    print("Unexpected error: \(response)")
                    self.delegate?.errorTransaction(self.text)
                }
            case let .failure(error):
                print("Request error: \(error)")
                self.delegate?.errorTransaction(self.text)
            }
        }
    }
}

// Mapping of data
extension CurrencyListNetworkService {
    
    private func mapTransactionList(response: Response) {
        do {
            if let array = try response.map(ResponseModel.self).stock {
                delegate?.succeessTransaction(array)
            }
            else {
                print("Another Unexpected error")
            }
        } catch {
            print("Unexpected error: \(error)")
        }
    }
}
