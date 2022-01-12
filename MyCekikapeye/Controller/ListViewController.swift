//
//  ListViewController.swift
//  MyCekikapeye
//
//  Created by Toto on 08/10/2021.
//

import UIKit
class ListViewController: UIViewController {

    @IBOutlet weak var spendingTableView: UITableView!
    var spendings = Spending.all
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        spendings = Spending.all
        spendingTableView.reloadData()
    }
    
}

// MARK: - protocols
extension ListViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { return spendings.count }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return spendings[section].count }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let person = spendings[section].first?.person?.name else {
            return nil
        }
        var totalAmount = 0.0
        for spending in spendings[section] {
            totalAmount += spending.amount
        }
        
        return "\(person) \(totalAmount)"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SpendingCell") else {
            return UITableViewCell()
        }

        let spending = spendings[indexPath.section][indexPath.row]
        cell.textLabel?.text = spending.content
        cell.detailTextLabel?.text = "\(spending.amount) \(SettingsService.currency)"
        
        return cell
    }
}

