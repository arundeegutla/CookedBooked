//
//  DoBViewController.swift
//  BeRealClone
//
//  Created by CHENGTAO on 3/29/23.
//

import UIKit
import ParseSwift


class DayOfBirthSignViewController: UIViewController {
    
    var username: String!
    var dob: Date?
    
    @IBOutlet weak var dobAskLabel: UILabel!
    @IBOutlet weak var dobDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dobAskLabel.text = "Hi \(username ?? "unknown"), when's your birthday?"
        
        // Change textColor of UIDatePicker
        dobDatePicker.setValue(UIColor.white, forKeyPath: "textColor")
        
        
    }
    
            
    @IBAction func didTappedContinue2(_ sender: Any) {
        
        dob = dobDatePicker.date
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let passwordViewController = segue.destination as? LastSignupStepViewController {
            passwordViewController.username = self.username
            passwordViewController.dob = self.dob
        }
    }
}
