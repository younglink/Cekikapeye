//
//  AddSpendingViewController.swift
//  MyCekikapeye
//
//  Created by Toto on 08/10/2021.
//

import UIKit

class AddSpendingViewController: UIViewController {


    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var peoplePickerView: UIPickerView!
    
//    var persons = [Person()]
    
    // MARK: - Affichage
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        amountLabel.text = "Montant (en \(SettingsService.currency))"
    }
        
    // MARK: - Actions
    @IBAction func add(_ sender: Any) {
      
        guard let description = descriptionTextField.text, let amount = amountTextField.text else {
                return
            }
        let spending = Spending(context: AppDelegate.viewContext)
        spending.content = description
        spending.amount = Double(amount) ?? 0.0
        spending.person = getSelectedPerson()
        try? AppDelegate.viewContext.save()
        refresh()
    }
    
    private func refresh() {
        descriptionTextField.text = ""
        amountTextField.text = ""
    }
    
    private func getSelectedPerson() -> Person? {
        if Person.count > 0 {
            let index = peoplePickerView.selectedRow(inComponent: 0)
            guard let persons = try? Person.all() else {
                print("On ne sait pas qui est cette personne...")
                return nil
            }
            return persons[index]
        }
        return nil
    }
    
}

// MARK: - Protocols

extension AddSpendingViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Person.count
    }
    
    func pickerView(_ pickerView: UIPickerView,titleForRow row: Int, forComponent component: Int) -> String? {
        guard let people = try? Person.all() else {
            return ""
        }
        return people[row].name
    }
    

}

// MARK: - Keyboard
extension AddSpendingViewController : UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        descriptionTextField.resignFirstResponder()
        amountTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == descriptionTextField {
            amountTextField.becomeFirstResponder()
        }
        return true
    }
}
