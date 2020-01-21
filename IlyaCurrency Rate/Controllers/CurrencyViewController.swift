//
//  CurrencyViewController.swift
//  IlyaCurrency Rate
//
//  Created by Admin on 21.01.2020.
//  Copyright © 2020 Ilya Ilushenko. All rights reserved.
//

import UIKit

class CurrencyViewController: UITableViewController {

    @IBOutlet private weak var refreshButton: UIBarButtonItem!
    var getRatesService: GetRatesService?
    var rates = Rates()
    @IBAction private func actionRefresh(_ sender: Any) {
        loadCurrencies()
        refreshButton.isEnabled = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        actionRefresh(self)
    }

    func loadCurrencies() {
        getRatesService = GetRatesService()
        getRatesService?.request(complition: { rates, error in
            DispatchQueue.main.async {
                if let rates = rates {
                    self.rates = rates
                } else {
                    print(error ?? "")
                }
                self.refreshButton.isEnabled = true
                self.tableView.reloadData()
            }
        })
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let rate = rates [indexPath.row]
        cell.textLabel?.text = "\(rate.baseCurrency)/\(rate.currency)"
        cell.detailTextLabel?.text = "Sell:\(rate.sell) Buy:\(rate.buy)"
return cell
    }
}
