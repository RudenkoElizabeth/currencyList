//
//  ViewController.swift
//  currencyList
//
//  Created by Elizabeth Rudenko on 10.04.2018.
//  Copyright © 2018 Elizabeth Rudenko. All rights reserved.
//

import UIKit
import MBProgressHUD

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var barButton: UIBarButtonItem?
    
    let viewModel = CurrencyListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        viewModel.invalidateTimer()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCurrencyListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell else {
            fatalError()
        }
        let data = viewModel.getCurrencyCellData(indexPath: indexPath)
        cell.nameLabel.text = data.name
        cell.amountLable.text = String(format:"%.2f", data.amount)
        cell.volumeLabel.text = String(data.volume)
        return cell
        
    }
    
    @IBAction func updateButtonTapped() {
        viewModel.updateCurrencyList()
    }
}

extension ViewController: CurrencyListViewModelDelegate {
    func updateNow() {
        MBProgressHUD.hide(for: self.view, animated: true)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        tableView?.reloadData()
    }
    
    func succeess() {
        MBProgressHUD.hide(for: self.view, animated: true)
        tableView?.reloadData()
    }
    
    func error(_ errorText: String) {
        MBProgressHUD.hide(for: self.view, animated: true)
        AlertHelper().messageAlert(stringMessage: errorText, vc: self)
    }

}

