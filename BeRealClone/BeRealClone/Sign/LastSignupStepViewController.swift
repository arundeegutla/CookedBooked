//
//  PasswordViewController.swift
//  BeRealClone
//
//  Created by CHENGTAO on 3/29/23.
//

import UIKit
import ParseSwift


class LastSignupStepViewController: UIViewController {

    var username: String!
    var dob: Date?
    
    @IBOutlet weak var userPasswordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func didTappedCongratulation(_ sender: Any) {
        guard let password = userPasswordField.text,
              !password.isEmpty
        else {
            showMissingFieldsAlert()
            return
        }
        
        var newUser = User()
        newUser.username = username
        newUser.dayOfBirth = dob
        newUser.password = password
                
        newUser.signup () { [weak self] result in
            
            switch result {
            case .success(let user):
                print("✅ Successfully signed up user \(user)")
                
                // Post a notification that the user has successfully signed up.
                NotificationCenter.default.post(name: Notification.Name("login"), object: nil)
                
            case .failure(let err):
                //Failed sign up
                self?.showAlert(description: err.localizedDescription)
                
            }
        }
        
        
    }
    
    private func showAlert(description: String?) {
        let alertController = UIAlertController(title: "Unable to Sign Up", message: description ?? "Unknown error", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    private func showMissingFieldsAlert() {
        let alertController = UIAlertController(title: "Opps...", message: "We need all fields filled out in order to sign you up.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
}
