//
//  SavedViewCell.swift
//  BeRealClone
//
//  Created by Khiem Tran Le on 4/21/23.
//

import UIKit

class SavedViewCell: UITableViewCell {

    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
