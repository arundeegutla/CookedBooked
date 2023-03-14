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
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var aveUsersRatingLabel: UILabel!
    @IBOutlet weak var totalVoteLabel: UILabel!

    @IBOutlet weak var popularityLabel: UILabel!
    
    @IBOutlet weak var overViewTextView: UITextView!
    
    @IBOutlet weak var ratingView: UIView!
    
    var tracks: MovieTrack!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        designUIView(Container: ratingView)
        Nuke.loadImage(with: ImageRequestURL(poster: tracks.backdrop_path, size: ImageSupportSize.original.rawValue), into: movieImageView)

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        releaseDateLabel.text = "\(dateFormatter.string(from: formattedReleaseDate(dateString: tracks.release_date)!)) Release"
        
        titleLabel.text = tracks.title
        aveUsersRatingLabel.text = "\(tracks.vote_average) Vote Average"
        totalVoteLabel.text = "\(tracks.vote_count) Vote"
        popularityLabel.text = "\(tracks.popularity) Popular"
        overViewTextView.text = "\(tracks.overview)"
        
    }
    
    func designUIView(Container: UIView) {
        Container.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        Container.layer.shadowOpacity = 1.0
        Container.layer.shadowRadius = 0.0
        Container.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        Container.layer.masksToBounds = true
        Container.layer.cornerRadius = 15
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
