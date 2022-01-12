//
//  PeopleViewController.swift
//  MyCekikapeye
//
//  Created by Toto on 08/10/2021.
//

import UIKit
import CoreData

class PeopleViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var peoplesTextView: UITextView!

// MARK: - Navigation
    @IBAction func dismissAddPeopleView(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPeople()
    }
}

// MARK: - Keyboard
extension PeopleViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let textField = nameTextField.text, textField != "",
              peoplesTextView.text != nil else {
            presentAlert(withMsg: "Votre nom d'utilisateur ne convient pas.")
            return true
        }
        
        peoplesTextView.text += textField + "\n"
        nameTextField.text = ""
        savePerson(named: textField)
        return true
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
    }
}
// MARK: - Data gesture
extension PeopleViewController {
    private func savePerson(named name : String) {
        let person = Person(context: AppDelegate.viewContext)
        person.name = name
        if (try? AppDelegate.viewContext.save()) == nil {
            presentAlert(withMsg: "Vos utilisateurs n'ont pas pu être sauvegardés")
        }
    }
    
    private func loadPeople() {
        guard let persons = try? Person.all() else {
            presentAlert(withMsg: "Les utilisateurs n'ont pas pu être récupérés")
            return
        }
        var peopleText = ""
        for person in persons {
            if let name = person.name {
                peopleText += name + "\n"
            }
        }
        peoplesTextView.text = peopleText
    }
}

// MARK: - Alert
extension PeopleViewController {
    func presentAlert(withMsg message : String) {
        let alert = UIAlertController(title: "Euuuuh", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Je m'en occupe", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
