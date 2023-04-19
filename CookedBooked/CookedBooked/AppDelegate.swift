//
//  AppDelegate.swift
//  CookedBooked
//
//  Created by CHENGTAO on 4/16/23.
//

import UIKit
import ParseSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        /// The snippet shown in the Parse docs also includes the application:didFinishLaunchingWithOptions: method, however that method is already provided by default in the app delegate. So you only need to reference the part related to the configuration and initialization of Parse.
        
        ParseSwift.initialize(applicationId: "992RzbU5380ci0Fz2nUMVtCEVkPkdHvx299neKlb",
                              clientKey: "H85rJFf8QqvFzElT2fjHfoA6cefZwvNpJsbshJ5n",
                              serverURL: URL(string: "https://parseapi.back4app.com")!)

        
//        serverConnectText()
        
        // Request authorization to send notifications.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
                if let error = error {
                    print("Error requesting notification authorization: \(error.localizedDescription)")
                } else if granted {
                    print("Notification authorization granted")
                } else {
                    print("Notification authorization denied")
                }
            }
        
        setNotification()
                
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate {
    
    /// Instantiate and save a test parse object to your server
    private func serverConnectText() {
        var score = GameScore()
        score.playerName = "Chengtao"
        score.points = 60
        
        // Save to your server asynchronously (preferred way) - Performs work on background queue and returns to specified callbackQueue.
        // If no callbackQueue is specified it returns to main queue.
        score.save { resul in
            switch resul {
            case .success(let saveScore):
                print("✅ Parse Object SAVED!: Player: \(String(describing: saveScore.playerName)), Score: \(String(describing: saveScore.points))")
            case .failure(let err):
                assertionFailure("Error saving: \(err)")
            }
        }
    }
    
    /// Instantiate Notification for App
    private func setNotification() {
        // Request authorization to send notifications.
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if let error = error {
                print("Error requesting notification authorization: \(error.localizedDescription)")
            } else if granted {
                print("Notification authorization granted")
            } else {
                print("Notification authorization denied")
            }
        }
    }
}


// Server Test Object Struct
struct GameScore: ParseObject {
    // These are required by ParseObject
        var objectId: String?
        var createdAt: Date?
        var updatedAt: Date?
        var ACL: ParseACL?
        var originalData: Data?

        // Your own custom properties.
        // All custom properties must be optional.
        var playerName: String?
        var points: Int?
}

// Sample Usage
//
// var score = GameScore()
// score.playerName = "Kingsley"
// score.points = 13

// OR Implement a custom initializer (OPTIONAL i.e. NOT REQUIRED)
// It's recommended to place custom initializers in an extension
// to preserve the member-wise initializer.
extension GameScore {
    // Use the init to set your custom properties
    // NOTE: Properties in custom init are NOT required to be optional
    init(playerName: String, points: Int) {
        self.playerName = playerName
        self.points = points
    }
}

