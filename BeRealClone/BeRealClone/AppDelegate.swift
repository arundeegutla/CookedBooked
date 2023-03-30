//
//  AppDelegate.swift
//  BeRealClone
//
//  Created by CHENGTAO on 3/25/23.
//

import UIKit
import ParseSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /// The snippet shown in the Parse docs also includes the application:didFinishLaunchingWithOptions: method, however that method is already provided by default in the app delegate. So you only need to reference the part related to the configuration and initialization of Parse.
        
        ParseSwift.initialize(applicationId: "ldr13GRaAqr3WmuMYWhj9v2ic0nJGS5NuUoqQ6WS",
                              clientKey: "j9YyogX893pfA7IjsSKPLxThZAZbkS0JrDIDoIpD",
                              serverURL: URL(string: "https://parseapi.back4app.com")!)


//        // TODO: Pt 1: - Instantiate and save a test parse object to your server
//        // https://github.com/parse-community/Parse-Swift/blob/3d4bb13acd7496a49b259e541928ad493219d363/ParseSwift.playground/Pages/1%20-%20Your%20first%20Object.xcplaygroundpage/Contents.swift#L121
//        var score = GameScore()
//        score.playerName = "Chengtao"
//        score.points = 60
//
//        // Save to your server asynchronously (preferred way) - Performs work on background queue and returns to specified callbackQueue.
//        // If no callbackQueue is specified it returns to main queue.
//        score.save { resul in
//            switch resul {
//            case .success(let saveScore):
//                print("✅ Parse Object SAVED!: Player: \(String(describing: saveScore.playerName)), Score: \(String(describing: saveScore.points))")
//            case .failure(let err):
//                assertionFailure("Error saving: \(err)")
//            }
//        }
        
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

//// TODO: Pt 1 - Create Test Parse Object
//// https://github.com/parse-community/Parse-Swift/blob/3d4bb13acd7496a49b259e541928ad493219d363/ParseSwift.playground/Pages/1%20-%20Your%20first%20Object.xcplaygroundpage/Contents.swift#L33
////
//// Create your own value type `ParseObject`.
//struct GameScore: ParseObject {
//    // These are required by ParseObject
//        var objectId: String?
//        var createdAt: Date?
//        var updatedAt: Date?
//        var ACL: ParseACL?
//        var originalData: Data?
//
//        // Your own custom properties.
//        // All custom properties must be optional.
//        var playerName: String?
//        var points: Int?
//}
//
//// Sample Usage
////
//// var score = GameScore()
//// score.playerName = "Kingsley"
//// score.points = 13
//
//// OR Implement a custom initializer (OPTIONAL i.e. NOT REQUIRED)
//// It's recommended to place custom initializers in an extension
//// to preserve the member-wise initializer.
//extension GameScore {
//    // Use the init to set your custom properties
//    // NOTE: Properties in custom init are NOT required to be optional
//    init(playerName: String, points: Int) {
//        self.playerName = playerName
//        self.points = points
//    }
//}
