//
//  SignUpViewController.swift
//  BeRealClone
//
//  Created by CHENGTAO on 3/26/23.
//

import UIKit
import ParseSwift

class UsernameSignUpViewController: UIViewController {
    
    var username: String!
    
    @IBOutlet weak var usernameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    
    @IBAction func didTappedContinue(_ sender: Any) {
        
        guard let username = usernameField.text,
              !username.isEmpty
        else {
            showMissingFieldsAlert()
            return
        }
        
        self.username = username
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let dayOfBirthViewController = segue.destination as? DayOfBirthSignViewController {
            dayOfBirthViewController.username = self.username
        }
           
        
    }
    

    private func showMissingFieldsAlert() {
        let alertController = UIAlertController(title: "Opps...", message: "We need all fields filled out in order to sign you up.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}
