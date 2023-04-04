//
//  PostViewController.swift
//  BeRealClone
//
//  Created by CHENGTAO on 3/29/23.
//

import UIKit
import PhotosUI
import ParseSwift
import CoreLocation


class PostViewController: UIViewController {

    
    @IBOutlet weak var captionTextLabel: UITextField!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var noLocation = false
    var userLocation : CLLocation!
    @Published var userAddress = "nil location"
    private var pickedImage: UIImage?
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUserLocation()
    }
    
    
    @IBAction func onSelectedImageTapped(_ sender: Any) {
        selectPhotoFromCamera()
//        selectPhotoFromUserLibrary()
    }
    
    @IBAction func onPostTapped(_ sender: Any) {
                
        // Dismiss Keyboard
        view.endEditing(true)
        
        if var currentUser = User.current {

            // Update the `lastPostedDate` property on the user with the current date.
            currentUser.lastPostedDate = Date()

            // Save updates to the user (async)
            currentUser.save { [weak self] result in
                switch result {
                case .success(let user):
                    print("✅ User Saved! \(user)")

                    // Switch to the main thread for any UI updates
                    DispatchQueue.main.async {
                        // Return to previous view controller
                        self?.navigationController?.popViewController(animated: true)
                    }

                case .failure(let error):
                    self?.showAlert(description: error.localizedDescription)
                }
            }
        }
        
        // Unwrap optional pickedImage
        guard let image = pickedImage,
              // Create and compress image data (jpeg) from UIImage
              let imageDate = image.jpegData(compressionQuality: 0.1) else { return }
        
        // Create a Parse File by providing a name and passing in the image data
        let imageFile = ParseFile(name: "image.jpg", data: imageDate)
        
        // Create a post object
        var post = Post()
        
        // Set properties
        post.imageFile = imageFile
        post.caption = captionTextLabel.text
        
        // Set the user as the current user
        post.user = User.current
        
        // Save object in background (async)
        post.save { [weak self] result in
            
            // Switch to the main thread for any UI updates
            DispatchQueue.main.async {
                switch result {
                case .success(let post):
                    print("✅ Post Saved! \(post)")
                    
                    // Return to previous view controller
                    // self?.navigationController?.popViewController(animated: true)
                case .failure(let err):
                    self?.showAlert(description: err.localizedDescription)
                }
            }
        }
        
    }
    
    
    
    private func updateUserLocation() {
        
        // Ask for permission to access the user's location
        locationManager.delegate = self
        
        //Ask location call
        locationManager.requestWhenInUseAuthorization()
        
        // Start updating the user's location
        locationManager.startUpdatingLocation()
        
    }
    
//    private func selectPhotoFromUserLibrary() {
//
//                // Create a configuration object
//                var config = PHPickerConfiguration()
//
//                // Set the filter to only show images as options (i.e. no videos, etc.).
//                config.filter = .images
//
//                // Request the original file format. Fastest method as it avoids transcoding.
//                config.selectionLimit = 1
//
//                // Instantiate a picker, passing in the configuration
//                let picker = PHPickerViewController(configuration: config)
//
//                // Set the picker delegate so we can receive whatever image the use pick.
//                picker.delegate = self
//
//                // Present the picker
//                present(picker, animated: true)
//    }
    
    private func selectPhotoFromCamera() {
        
        
        // Make sure the user's camera is available
        // NOTE: Camera only available on physical iOS device, not available on simulator.
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("❌📷 Camera not available")
            return
        }

        // Instantiate the image picker
        let imagePicker = UIImagePickerController()

        // Shows the camera (vs the photo library)
        imagePicker.sourceType = .camera

        // Allows user to edit image within image picker flow (i.e. crop, etc.)
        // If you don't want to allow editing, you can leave out this line as the default value of `allowsEditing` is false
        imagePicker.allowsEditing = true

        // The image picker (camera in this case) will return captured photos via it's delegate method to it's assigned delegate.
        // Delegate assignee must conform and implement both `UIImagePickerControllerDelegate` and `UINavigationControllerDelegate`
        imagePicker.delegate = self

        // Present the image picker (camera)
        present(imagePicker, animated: true)

    }
    
    private func showAlert(description: String? = nil) {
        let alertController = UIAlertController(title: "Oops...", message: "\(description ?? "Please try again...")", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    private func showErrorAlert(for error: Error? = nil) {
        let alertController = UIAlertController(
            title: "Oops...",
            message: "\(error?.localizedDescription ?? "Please try again...")",
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        
        present(alertController, animated: true)
    }
    
    @IBAction func onViewTapped(_ sender: Any) {
        
        // Dismiss keyboard
        view.endEditing(true)

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let feedViewController = segue.destination as? FeedViewController {
            feedViewController.userLocation = self.userAddress
        }
    }
    
}


//extension PostViewController: PHPickerViewControllerDelegate {
//    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//
//        // Dismiss the picker for allowing the user to return to the previous screen and continue using the app
//        picker.dismiss(animated: true)
//
//        // Make sure we have a non-nil item provider
//        guard let provider = results.first?.itemProvider,
//              // Make sure the provider can load a UIImage
//              provider.canLoadObject(ofClass: UIImage.self) else { return }
//
//        provider.loadObject(ofClass: UIImage.self) { [weak self] obj, err in
//
//            // Make sure we can cast the returned object to a UIImage
//            guard let image = obj as? UIImage else {
//
//                // ❌ unable to cast to UIImage
//                self?.showAlert()
//                return
//            }
//
//            // Check for and handle any errors
//            if let error = err {
//
//                self?.showErrorAlert(for: error)
//
//                return
//
//            } else {
//
//                // UI updated (like setting image on image view) should be done here
//                DispatchQueue.main.async {
//
//                    // Set image on preview image view
//                    self?.photoImageView.image = image
//
//                    // Set image to use when saving post
//                    self?.pickedImage = image
//
//                }
//            }
//        }
//    }
//
//}

extension PostViewController: CLLocationManagerDelegate {
        
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        //Checking location assess...
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("authorized")

            manager.requestLocation()
        case .denied:
            print("denied")
            self.noLocation = true
        default:
            print("unknown")
            //Direct call
            locationManager.requestWhenInUseAuthorization()
            // Modifying Info.plist...
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // reading User Location
        self.userLocation = locations.last
        self.getLocation()
        
    }
    
    private func getLocation() {
        CLGeocoder().reverseGeocodeLocation(self.userLocation) {(res, err) in
            guard let safeData = res else { return }
            var address = ""
            
            // Get street address
//            address += safeData.first?.name ?? ""
//            address += ","
            
            // get City address
            address += safeData.first?.locality ?? ""
            self.userAddress = address
        }
    }
}

extension PostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        // Dismiss the image picker
        picker.dismiss(animated: true)

        // Get the edited image from the info dictionary (if `allowsEditing = true` for image picker config).
        // Alternatively, to get the original image, use the `.originalImage` InfoKey instead.
        guard let image = info[.editedImage] as? UIImage else {
            print("❌📷 Unable to get image")
            return
        }

        // Set image on preview image view
        photoImageView.image = image

        // Set image to use when saving post
        pickedImage = image
    }

}

