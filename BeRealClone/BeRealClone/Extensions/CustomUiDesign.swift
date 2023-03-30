//
//  CustomUiDesign.swift
//  BeRealClone
//
//  Created by CHENGTAO on 3/29/23.
//

import UIKit
import Foundation

func userImageDesign(userImageView: UIImageView, username firstName: String) -> UIImageView? {
    userImageView.layer.cornerRadius = userImageView.frame.size.width / 2
    userImageView.layer.masksToBounds = true
    let firstChar = firstName.first?.uppercased() ?? ""
    let initialsLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    initialsLabel.text = firstChar
    initialsLabel.textColor = UIColor.white
    initialsLabel.textAlignment = .center
    initialsLabel.font = UIFont.boldSystemFont(ofSize: 40.0)
    initialsLabel.backgroundColor = UIColor.gray
    initialsLabel.layer.cornerRadius = 50.0
    initialsLabel.clipsToBounds = true
    
    // Convert the label to an image
    UIGraphicsBeginImageContextWithOptions(initialsLabel.bounds.size, false, 0.0)
    initialsLabel.layer.render(in: UIGraphicsGetCurrentContext()!)
    let initialsImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    userImageView.image = initialsImage
    
    return userImageView
}
