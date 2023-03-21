//
//  Task.swift
//  PhotoScavengerHunt
//
//  Created by CHENGTAO on 3/19/23.
//

import CoreLocation
import UIKit

class Task {
    let title: String
    let description: String
    var image: UIImage?
    var imageLocation: CLLocation?
    var isComplete: Bool {
        image != nil
    }
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
    
    func set(_ image: UIImage, with location: CLLocation) {
        self.image = image
        self.imageLocation = location
    }
}

// MARK: Helper methods

/// Return a "checkmark.circle"  symbol image, if isCompleted is true, otherwise, return an "circle"  image
func completedImage(isComplete: Bool) -> UIImage? {
    UIImage(systemName: isComplete ? "checkmark.circle" : "circle")
}

/// Return Green color if isComplete is true, otherwise, return Red color.
func checkMarkColor(isComplete: Bool) -> UIColor {
    isComplete ? .systemGreen : .systemRed
}


extension Task {
    static var mockedTasks: [Task] {
        return [
            Task(title: "Your favorite local restaurant",
                 description: "Where do you go to satisfy your cravings for delicious food?"),
            Task(title: "Your favorite local cafe",
                 description: "Where do you go to unwind, relax, and enjoy a cup of coffee or tea?"),
            Task(title: "Your go-to brunch place",
                 description: "Brunch is the best of both worlds - breakfast and lunch combined into one delicious meal!"),
            Task(title: "Your favorite hiking spot",
                 description: "Where do you go to be one with nature?")
        ]
    }
}
