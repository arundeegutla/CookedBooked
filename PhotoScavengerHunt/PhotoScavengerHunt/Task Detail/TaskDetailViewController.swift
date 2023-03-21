//
//  ViewController.swift
//  PhotoScavengerHunt
//
//  Created by CHENGTAO on 3/19/23.
//

import UIKit
import MapKit
import PhotosUI

class TaskDetailViewController: UIViewController {
    
    @IBOutlet weak var taskCompletedImageView: UIImageView!
    
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var taskDescriptionLabel: UILabel!
    
    @IBOutlet weak var photoMapView: MKMapView!
    @IBOutlet weak var attachPhotoB: UIButton!
    
    var task: Task!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        photoMapView.layer.cornerRadius = 12
        
        updateUI()
        updateMapView()
        updateAnnotation()
        
        
    }

    // Configure UI for the given task from TaskViewController
    private func updateUI() {
        
        taskTitleLabel.text = task.title
        taskDescriptionLabel.text = task.description
        
        // calling `withRenderingMode(.alwaysTemplate)` on an image allows for coloring the image via it's `tintColor` property.
        taskCompletedImageView.image = completedImage(isComplete: task.isComplete)?.withRenderingMode(.alwaysTemplate)
        
        taskCompletedImageView.tintColor = checkMarkColor(isComplete: task.isComplete)
        
        // hidden attach photo buttonUI after photo selected.
        attachPhotoB.isHidden = task.isComplete
    }
    
    private func updateMapView() {
        // Make sure the task has image location.
        guard let imageLocation = task.imageLocation else { return }
        
        // Get the coordinate from the image location. This is the latitude / longitude of the location.
        let coordinate = imageLocation.coordinate
        
        // Set the map view's region based on the coordinate of the image.
        // The span represents the map's "zoom level". A smaller value yields a more "zoom in" map area, while a larger value is more "zoom out".
        let region = MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        photoMapView.setRegion(region, animated: true)
        
        // Add an annotation to the map view based on image location
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        photoMapView.addAnnotation(annotation)
        
    }
    
    private func updateAnnotation() {
        // Register custom annotation view
        photoMapView.register(TaskAnnotationView.self, forAnnotationViewWithReuseIdentifier: TaskAnnotationView.identifier)
        
        // Set mapView delegate
        photoMapView.delegate = self
    }
    
    @IBAction func didTapAttachPhotoButton(_ sender: Any) {
        
        // If authorized, show photo picker, otherwise request authorization.
        // If authorization denied, show alert with option to go to settings to update authorization.
        
        if PHPhotoLibrary.authorizationStatus(for: .readWrite) != .authorized {
            // Request photo library access
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { [weak self] status in switch status {
            case .authorized:
                // The user authorized access to their photo library
                // show picker (on main thread)
                DispatchQueue.main.async {
                    self?.presentImagePicker()
                }
            default:
                // Show settings alert (on main thread)
                self?.presentGoToSettingsAlert()

            }
            }
        } else {
            
            // Show photo picker
            presentImagePicker()
            
        }
    }
    
    private func presentImagePicker() {
        
        // Create a configuration object
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        
        // Set the filter to only show images as options (i.e no video, etc.)
        config.filter = .images
        
        // Request the original file format, Fastest method as it avoids transcoding.
        config.preferredAssetRepresentationMode = .current
        
        // Only allow one image to be selected at a time.
        config.selectionLimit = 1
        
        // Instantiate a picker, passing in the configuration.
        let picker = PHPickerViewController(configuration: config)
        
        // Set the picker delegate so we can receive whatever image the user picks.
        picker.delegate = self
        
        // Present the picker.
        present(picker, animated: true)
        
    }
    
    private func showAlert(for error: Error? = nil) {
        let alertController = UIAlertController(
            title: "Oops...",
            message: "\(error?.localizedDescription ?? "Please try again...")",
            preferredStyle: .alert
        )
        
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        
        present(alertController, animated: true)
    }
    

}

extension TaskDetailViewController {
    /// Presents an alert notifying user of photo library access requirement with an option to go to Settings in order to update status.
    func presentGoToSettingsAlert() {
        let alertController = UIAlertController (
            title: "Photo Access Required",
            message: "In order to post a photo to complete a task, we need access to your photo library. You can allow access in Settings",
            preferredStyle: .alert)
        
        let settingAction = UIAlertAction(title: "Settings", style: .default) { _ in
            guard let settingUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            
            if UIApplication.shared.canOpenURL(settingUrl) {
                UIApplication.shared.open(settingUrl)
            }
        }
        
        alertController.addAction(settingAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
}


extension TaskDetailViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        // This is where we'll get the picked image in the next step...
        
        // Dismiss the picker
        picker.dismiss(animated: true)
        
        // Get the selected image asset (we can grab the 1st item in the array since we only allowed a selection limit of 1)
        let result = results.first
        
        // Get image location
        // PHAsset contains metadata about an image or video (ex. location, size, etc.)
        guard let assetId = result?.assetIdentifier,
              let location = PHAsset.fetchAssets(withLocalIdentifiers: [assetId], options: nil).firstObject?.location else { return }
        
//        print("📍 Image location coordinate: \(location.coordinate)")
        
        // Make sure we have a non-nil item provider
        guard let provider = result?.itemProvider,
              provider.canLoadObject(ofClass: UIImage.self) else { return }
        
        // Load a UIImage from the provider
        provider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
            
            // Handle any errors
            if let error = error {
                DispatchQueue.main.async {
                    [weak self] in self?.showAlert(for: error)
                }
            }
            
            // Make sure we can cast the returned object to a UIImage
            guard let image = object as? UIImage else { return }
            
//            print("🌉 We have an image!")
            
            // UI updates should be done on main thread, hence the use of `DispatchQueue.main.async`
            DispatchQueue.main.async {
                
                // Set the picked image and location on the task
                self?.task.set(image, with: location)
                
                // Update the UI since we've updated the task
                self?.updateUI()
                
                // Update the main view since we now have image an location
                self?.updateMapView()
                
            }
        }
    }
}

// Unlike many delegate protocols, the MKMapViewDelegate doesn't have any required methods we need to implement, and so we don't get any errors at this point.
extension TaskDetailViewController: MKMapViewDelegate {
    
    // Add the following optional delegate method (to the above extension) which will allow us to create and return the custom annotation view for the map view to use when it displays an annotation.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // Dequeue the annotation view for the specified reuse identifier and annotation.
        // Cast the dequeued annotation view to your specific custom annotation view class, `TaskAnnotationView`
        // 💡 This is very similar to how we get and prepare cells for use in table views.
        guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: TaskAnnotationView.identifier, for: annotation) as? TaskAnnotationView else {
            fatalError("Unable to dequeue TaskAnnotationView")
        }
        
        // Configure the annotation view, passing in the task's image.
        annotationView.configure(with: task.image)
        return annotationView
    }
}
