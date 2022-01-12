//
//  SettingsViewController.swift
//  MyCekikapeye
//
//  Created by Toto on 08/10/2021.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var currencyLabel: UILabel!

// MARK: - Affichage
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyLabel.text = SettingsService.currency
    }

// MARK: - Gestion
    @IBAction func changeCurrency(_ sender: UIButton) {
        guard let currency = sender.currentTitle else {return}
        currencyLabel.text = currency
        SettingsService.currency = currency
    }
}

// MARK: - Navigation
extension SettingsViewController {
    @IBAction func dismissSettingsView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        present(SettingsViewController(), animated: true, completion: nil)
    }
}
