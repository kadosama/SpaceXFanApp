import SwiftUI
import Firebase
import RealmSwift
import GoogleSignIn


func configureRealm() {
    let config = Realm.Configuration(
        // Set the new schema version
        schemaVersion: 4, // Increment this when you change your schema

        // Define the migration block
        migrationBlock: { migration, oldSchemaVersion in
            if oldSchemaVersion < 3 {
                // Handle the migration for adding 'user_id' property to FavoriteRocket
                migration.enumerateObjects(ofType: FavoriteRocket.className()) { oldObject, newObject in
                    // Initialize the new 'user_id' property with a default value (e.g., empty string)
                    newObject!["user_id"] = "" // Set a default value for existing objects
                }
            }
        }
    )

    // Set the new configuration as the default configuration
    Realm.Configuration.defaultConfiguration = config

    do {
        _ = try Realm() // Initialize Realm with the new configuration
        print("Realm initialized successfully")
    } catch {
        print("Failed to initialize Realm: \(error)")
    }
}


@main
struct SpaceXApp: SwiftUI.App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                SplashScreen() // Assuming SplashScreen is your initial view
            }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure() // Initialize Firebase
        configureRealm() // Initialize Realm as the app launches
        return true
    }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
}


