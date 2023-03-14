//
//  ViewController.swift
//  Flixster
//
//  Created by CHENGTAO on 3/5/23.
//

import UIKit


class MovieViewController: UIViewController, UITableViewDataSource {

    var movieTracks: [MovieTrack] = []
    let apiKey = "2caf36b8c91eecca427bf0e0751b5c9c"
    
    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // extend all movie info to movieTracks array
        //movieTracks = MovieTrack.movieInfo
        
        // Create a URL for the request
        // In this case, the custom search URL you created in in part 1
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)") else {
            return
        }
        
        // Use the URL to instantiate a request
        let request = URLRequest(url: url)

        // Create a URLSession using a shared instance and call its dataTask method
        // The data task method attempts to retrieve the contents of a URL based on the specified URL.
        // When finished, it calls it's completion handler (closure) passing in optional values for data (the data we want to fetch), response (info about the response like status code) and error (if request was unsuccessful).
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
            // Handle any errors
            if let error = error {
                print("❌ Network error: \( error.localizedDescription)")
            }
            
            // Make sure we have data
            guard let data = data else {
                print("❌ Data is nil")
                return
            }
            
            // Create a JSON Decoder
            let decoder = JSONDecoder()
                        
            // The `JSONSerialization.jsonObject(with: data)` method is a "throwing" function (meaning it can throw an error) so we wrap it in a `do` `catch`
            do {
                
                // Create a date formatter
                let dateFormatter = DateFormatter()

                // Set a custom date format based on what we see coming back in the JSON
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

                // Set the decoding strategy on the JSON decoder to use our custom date format
                decoder.dateDecodingStrategy = .formatted(dateFormatter)

                // Use the JSON decoder to try and map the data to our custom model.
                // TrackResponse.self is a reference to the type itself, tells the decoder what to map to.
                let response = try decoder.decode(MovieTrackResponse.self, from: data)

                // Access the array of tracks from the `results` property
                let tracks = response.results
            
//                print("✅ \(tracks)")
                
                // Execute UI updates on the main thread when calling from a background callback
                DispatchQueue.main.async {
                    
                    self?.movieTracks = tracks
                    
                    self?.movieTableView.reloadData()
                    
                }
                
            } catch {
                print("❌ Error parsing JSON \(error.localizedDescription)")
            }
        }.resume() // <-Initiate the network request

        
        
        //print(movieTracks)
        
        movieTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieTracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieTrackCell
        
        let movieTracks = movieTracks[indexPath.row]
        
        cell.configure(with: movieTracks)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // Get the cell that triggered the segue
        if let cell = sender as? UITableViewCell,
           // Get the index path of the cell from the table view
           let indexPath = movieTableView.indexPath(for: cell),
           // Get the detail view controller
           let movieDetailViewController = segue.destination as? MovieDetailViewController {
            
            // Use the index path to get the associated track
            let tracks = movieTracks[indexPath.row]
            
            // Set the track on the detail view controller
            movieDetailViewController.tracks = tracks
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = movieTableView.indexPathForSelectedRow {
            
            movieTableView.deselectRow(at: indexPath, animated: true)
            
        }
    }
      
}

