//
//  LoginViewController.swift
//  CookedBooked
//
//  Created by CHENGTAO on 4/16/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var usernameTextLabel: UITextField!
    @IBOutlet weak var passwordTextLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onLoginTapped(_ sender: Any) {
        // Make sure all fields are non-nil and non-empty.
        guard let username = usernameTextLabel.text,
              let password = passwordTextLabel.text,
              !username.isEmpty,
              !password.isEmpty else {

            showMissingFieldsAlert()
            return
        }

        User.login(username: username, password: password) { [weak self] result in

            switch result {
            case .success(let user):
                print("✅ Successfully logged in as user: \(user)")

                // Post a notification that the user has successfully logged in.
                NotificationCenter.default.post(name: Notification.Name("login"), object: nil)

            case .failure(let error):
                // Show an alert for any errors
                self?.showAlert(description: error.localizedDescription)
            }
        }
    }
    
    
    @IBAction func onSignInTapped(_ sender: Any) {
        // Make sure all fields are non-nil and non-empty.
        guard let username = usernameTextLabel.text,
              let password = passwordTextLabel.text,
              !username.isEmpty,
              !password.isEmpty else {

            showMissingFieldsAlert()
            return
        }

        User.login(username: username, password: password) { [weak self] result in

            switch result {
            case .success(let user):
                print("✅ Successfully logged in as user: \(user)")

                // Post a notification that the user has successfully logged in.
                NotificationCenter.default.post(name: Notification.Name("login"), object: nil)

            case .failure(let error):
                // Show an alert for any errors
                self?.showAlert(description: error.localizedDescription)
            }
        }
    }
    
    
    private func showMissingFieldsAlert() {
        let alertController = UIAlertController(title: "Opps...", message: "We need all fields filled out in order to log you in.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}
