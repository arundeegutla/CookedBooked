//
//  MovieTrackCell.swift
//  Flixster
//
//  Created by CHENGTAO on 3/6/23.
//

import UIKit
import Nuke

class MovieTrackCell: UITableViewCell {
   
    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var shortDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with track: MovieTrack) {
        movieNameLabel.text = track.trackName
        shortDescriptionLabel.text = track.shortDescription
        
        Nuke.loadImage(with: track.artworkUrl100, into: movieImageView)
    }

}
