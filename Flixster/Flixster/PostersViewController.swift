//
//  AlbumsViewController.swift
//  Flixster
//
//  Created by CHENGTAO on 3/13/23.
//

import UIKit
import Nuke

class PostersViewController: UIViewController, UICollectionViewDataSource {

    var posters: [Poster] = []
    let apiKey = "2caf36b8c91eecca427bf0e0751b5c9c"
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateCollectionViewLayout()
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)") else {
            return
        }
        
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
            if let error = error {
                print("❌ Network error: \( error.localizedDescription)")
            }
            
            guard let data = data else {
                print("❌ Data is nil")
                return
            }
            
            let decoder = JSONDecoder()
                        
            do {
                
                let response = try decoder.decode(PosterSearchResponse.self, from: data)

                let posters = response.results
                
//                print("✅ \(posters)")
                
                DispatchQueue.main.async {
                    
                    self?.posters = posters

                    self?.collectionView.reloadData()
                    
                }

                
            } catch {
                print("❌ Error parsing JSON \(error.localizedDescription)")
            }
        }.resume()
        
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        posters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        
        let poster = posters[indexPath.item]
        
        let imageUrl = poster.poster_path
        
        Nuke.loadImage(with: ImageRequestURL(poster: imageUrl, size: ImageSupportSize.w500.rawValue), into: cell.posterImageView)
        
        return cell
    }
    
    func updateCollectionViewLayout() {
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumInteritemSpacing = 4
        
        layout.minimumLineSpacing = 4
        
        let numberOfColums: CGFloat = 3
        
        let width = (collectionView.bounds.width - layout.minimumInteritemSpacing * (numberOfColums - 1)) / numberOfColums
        
        layout.itemSize = CGSize(width: width, height: width)
        
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
