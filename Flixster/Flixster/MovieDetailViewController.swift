//
//  MovieDetailViewController.swift
//  Flixster
//
//  Created by CHENGTAO on 3/6/23.
//

import UIKit
import Nuke

class MovieDetailViewController: UIViewController {

    
    @IBOutlet weak var movieImageView: UIImageView!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var primaryGenreNameLabel: UILabel!
    @IBOutlet weak var trackTimeMillisLabel: UILabel!
    
    @IBOutlet weak var aveUsersRatingLabel: UILabel!
    @IBOutlet weak var totalVoteLabel: UILabel!
        
    @IBOutlet weak var longDescriptionLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    var tracks: MovieTrack!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Nuke.loadImage(with: tracks.artworkUrl100, into: movieImageView)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        releaseDateLabel.text = dateFormatter.string(from: tracks.releaseDate)
        
        artistNameLabel.text = tracks.artistName
        primaryGenreNameLabel.text = tracks.primaryGenreName
        trackTimeMillisLabel.text = formattedTrackDuration(with: tracks.trackTimeMillis)
        aveUsersRatingLabel.text = "\(tracks.rating.averageUserRating)"
        totalVoteLabel.text = "\(formatNumber(tracks.rating.totalVote)) people vote"
        longDescriptionLabel.text = tracks.longDescription
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
