//
//  ViewController.swift
//  Flixster
//
//  Created by CHENGTAO on 3/5/23.
//

import UIKit


class MovieViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieTracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTrackCell
        
        let movieTracks = movieTracks[indexPath.row]
        
        cell.configure(with: movieTracks)
        
        return cell
    }
    
    
    var movieTracks: [MovieTrack] = []
    
    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // extend all movie info to movieTracks array
        movieTracks = MovieTrack.movieInfo
        
        //print(movieTracks)
        
        movieTableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let cell = sender as? UITableViewCell,
           let indexPath = movieTableView.indexPath(for: cell),
           let movieDetailViewContorller = segue.destination as? MovieDetailViewController {
            let tracks = movieTracks[indexPath.row]
            movieDetailViewContorller.tracks = tracks
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = movieTableView.indexPathForSelectedRow {
            
            movieTableView.deselectRow(at: indexPath, animated: true)
            
        }
    }
      
}

