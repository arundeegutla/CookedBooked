//
//  ViewController.swift
//  BeRealClone
//
//  Created by CHENGTAO on 3/25/23.
//

import UIKit
import UserNotifications
import ParseSwift

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }


    @IBAction func didTappedLogin(_ sender: Any) {
        
        // Make sure all fields are non-nil and non-empty.
        guard let username = usernameTextField.text,
              let password = passwordTextField.text,
              !username.isEmpty,
              !password.isEmpty else {

            showMissingFieldsAlert()
            return
        }

        // TODO: Pt 1 - Log in the parse user
        
        // Log in the parse user
        User.login(username: username, password: password) { [weak self] result in

            switch result {
            case .success(let user):
                print("✅ Successfully logged in as user: \(user)")
                self?.scheduleNotification()

                // Post a notification that the user has successfully logged in.
                NotificationCenter.default.post(name: Notification.Name("login"), object: nil)

            case .failure(let err):
                self?.showAlert(description: err.localizedDescription)
            }
        }
        
    }
    
    func scheduleNotification() {
        notificationCenter.getNotificationSettings { (settings) in
            
            DispatchQueue.main.async {
                
                if settings.authorizationStatus == .authorized {
                                    
                    let content = UNMutableNotificationContent()
                        content.title = "ReReal"
                        content.body = "Remember to upload today's photo!"
                        content.sound = .default
                    
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: (3600*24), repeats: true)
                        
                        let request = UNNotificationRequest(identifier: "dailyReminder", content: content, trigger: trigger)
                        
                        UNUserNotificationCenter.current().add(request) { (error) in
                            if let error = error {
                                print("Error scheduling notification: \(error.localizedDescription)")
                            } else {
                                print("Notification scheduled")
                            }
                        }
                    
                } else {
                    print(" Failed!")
                }
                
            }
        }
    }
    
    private func showAlert(description: String?) {
        let alertController = UIAlertController(title: "Unable to Log in", message: description ?? "Unknown error", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }

    private func showMissingFieldsAlert() {
        let alertController = UIAlertController(title: "Opps...", message: "We need all fields filled out in order to log you in.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}

