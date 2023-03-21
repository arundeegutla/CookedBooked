//
//  TaskCell.swift
//  PhotoScavengerHunt
//
//  Created by CHENGTAO on 3/19/23.
//

import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var taskCheckMark: UIImageView!
    
    func configure(with task: Task) {
        taskLabel.text = task.title
        taskLabel.textColor = task.isComplete ? .secondaryLabel : .label
        
        taskCheckMark.image = completedImage(isComplete: task.isComplete)?.withRenderingMode(.alwaysTemplate)
        taskCheckMark.tintColor = checkMarkColor(isComplete: task.isComplete)
    }
    
}
