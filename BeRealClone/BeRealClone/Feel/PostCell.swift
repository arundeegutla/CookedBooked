//
//  PostCell.swift
//  BeRealClone
//
//  Created by CHENGTAO on 3/29/23.
//

import UIKit
import Alamofire
import AlamofireImage

class PostCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var postPhotoImageView: UIImageView!
    
    var postStateLocation: String!

    private var imageDataRequest: DataRequest?

    func configure(with post: Post) {
        
        // Username
        if let user = post.user {
            usernameLabel.text = user.username
            
            userImage = userImageDesign(userImageView: userImage, username: user.username!)
            
        }
        
        
        // Image
        if let imageFile = post.imageFile,
           let imageUrl = imageFile.url {
            
            // Use AlamofireImage helper to fetch remote image from URL
            imageDataRequest = AF.request(imageUrl).responseImage { [weak self] response in
                switch response.result {
                case .success(let image):
                    // Set image view image with fetched image
                    self?.postPhotoImageView.image = image
                    
                case .failure(let err):
                    print("❌ Error fetching image: \(err.localizedDescription)")
                    break
                }
            }
        }
        
        // Caption
        captionLabel.text = post.caption
        
        // Date
        if let date = post.createdAt {
            locationLabel.text = DateFormatter.postFormatter.string(from: date)
        }

    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Reset image view image
        postPhotoImageView.image = nil
        
        // Cancel image request.
        imageDataRequest?.cancel()
        
    }
}
