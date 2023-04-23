//
//  UserAccountManagement.swift
//  CookedBooked
//
//  Created by CHENGTAO on 4/22/23.
//

import Foundation
import ParseSwift

func userPasswordReset(userEmailTextField: UITextField, newPasswordTextField: UITextField, confirmPasswordTextField: UITextField) {
    
    guard let userEmail = userEmailTextField.text,
          let newPassword = newPasswordTextField.text,
          let confirmPassword = confirmPasswordTextField.text
    else {
        print("Error: One or more text fields are empty.")
        return
    }
    
    if newPassword != confirmPassword {
        print("Error: New password and confirm password fields do not match.")
        return
    }
    
    User.passwordReset(email: userEmail) { result in
        switch result {
        case .success:
            print("Password reset instructions sent to email: \(userEmail)")
        case .failure(let error):
            print("Error resetting password: \(error.localizedDescription)")
        }
    }
}

