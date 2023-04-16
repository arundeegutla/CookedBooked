//
//  SignViewController.swift
//  CookedBooked
//
//  Created by CHENGTAO on 4/16/23.
//

import UIKit

class SignViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    
    // Go to login sc
    @IBAction func didSignInTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let signUpViewController = storyboard.instantiateViewController(withIdentifier: "Login&SignIn") as? LoginViewController {
                self.navigationController?.pushViewController(signUpViewController, animated: true)
            }
    }
    


}
