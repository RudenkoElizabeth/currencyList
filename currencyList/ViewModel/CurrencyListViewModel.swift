//
//  ViewModel.swift
//  currencyList
//
//  Created by Elizabeth Rudenko on 11.04.2018.
//  Copyright © 2018 Elizabeth Rudenko. All rights reserved.
//

import Foundation

protocol CurrencyListViewModelDelegate: class {
    func succeess()
    func error(_ errorText: String)
    func updateNow()
}

class CurrencyListViewModel {
    
    var updateTimer: Timer?
    var currencyArray = [CurrencyModel]()
    weak var delegate: CurrencyListViewModelDelegate?
    let currencyListNetworkService = CurrencyListNetworkService()
    
    
    init() {
        currencyListNetworkService.delegate = self
        updateCurrencyList()
    }
    
    func initTimer() {
        updateTimer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(updateCurrencyList), userInfo: nil, repeats: false)
    }
    
    func invalidateTimer() {
        if updateTimer != nil {
            updateTimer?.invalidate()
            updateTimer = nil
        }
    }
    
    func getCurrencyListCount() -> Int {
        return currencyArray.count
    }
    
    func getCurrencyCellData(indexPath: IndexPath) -> (name: String, volume: Int, amount: Double) {
        guard let name = currencyArray[indexPath.row].name,
            let volume = currencyArray[indexPath.row].volume,
            let amount = currencyArray[indexPath.row].price?.amount
            else {
                print ("error")
                return ("", 0, 0.0)
        }
        return (name, volume, amount)
    }
    
    @objc func updateCurrencyList() {
        currencyArray.removeAll()
        delegate?.updateNow()
       invalidateTimer()
        currencyListNetworkService.getList()
    }
}


extension CurrencyListViewModel: CurrencyListDelegate {
    func succeessTransaction(_ array: [CurrencyModel]) {
        self.currencyArray = array
        delegate?.succeess()
        initTimer()
    }
    
    func errorTransaction(_ errorText: String) {
        delegate?.error(errorText)
        initTimer()
    }
}
