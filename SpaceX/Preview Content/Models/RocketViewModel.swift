//
//  RocketViewModel.swift
//  SpaceX
//
//  Created by Kadir Erlik on 19.08.2024.
//

import SwiftUI
import RealmSwift
import FirebaseAuth
import FirebaseFirestore



final class RocketViewModel: ObservableObject {
    
    @Published var rockets: [Rocket] = []
    @Published var favoriteRockets: [Rocket] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading = false
    @Published var selectedRocket: Rocket?
    private var userID : String?
    
    private let realm = try! Realm()
    private let database = Firestore.firestore()

    init() {
        
        
        fetchCurrentUserID()

        /*do {
            realm = try Realm()
        } catch {
            // Handle the error here, e.g., logging or showing an alert
            print("Failed to initialize Realm: \(error.localizedDescription)")
            // Optionally, you could set realm to nil or handle it in a way that your app can recover or inform the user
        }
        */
}
    
    func fetchCurrentUserID () {
        if let user = Auth.auth().currentUser {
            self.userID = user.uid
    }
        else {
            return
        }
}

    func toggleFavorite(for rocket: Rocket) {
        for i in 0..<rockets.count {
            if rockets[i].id == rocket.id {
                rockets[i].toggleFavorite()
                if rockets[i].isFavorite {
                    saveFavoriteRealm(for: rockets[i])
                    saveFavoriteRocketToFirestore(rocket, userID : userID ?? "")
                } else {
                    removeFavoriteRealm(for: rockets[i])
                    removeFavoriteRocketFromFirestore(rocket, userID : userID ?? "")
                    removeRocketFromFavorites(rocket)

                }
                break
            }
        }
    }
    
    func fetchFavoriteRockets() {
         guard let userID = userID else { return }

         database.collection("users").document(userID).collection("favRockets")
             .getDocuments { snapshot, error in
                 if let error = error {
                     print("Error fetching favorite rockets from Firestore: \(error)")
                     return
                 }

                 var favorites: [Rocket] = []

                 if let documents = snapshot?.documents {
                     for document in documents {
                         let data = document.data()
                         if let rocketID = data["id"] as? String {
                             for rocket in self.rockets {
                                 if rocket.id == rocketID {
                                     favorites.append(rocket)
                                     break
                                 }
                             }
                         }
                     }
                 }

                 DispatchQueue.main.async {
                     self.favoriteRockets = favorites
                 }
             }
     }
 


    func fetchFavoriteRocketsFromRealm() {
        let favoriteRocketObjects = realm.objects(FavoriteRocket.self)
        var favorites: [Rocket] = []

            for favoriteRocket in favoriteRocketObjects {
                for rocket in rockets {
                    if favoriteRocket.id == rocket.id {
                        favorites.append(rocket)
                        break
                    }
                }
            }
        

          DispatchQueue.main.async {
              self.favoriteRockets = favorites
          }
    
    }
    
     func syncFavoriteStatus() {
         // fetchFavoriteRockets()

         for favorite in favoriteRockets {
             for i in 0..<rockets.count {
                 if rockets[i].id == favorite.id {
                     rockets[i].isFavorite = true
                     break
                 }
             }
         }
    }
    
    private func saveFavoriteRocketToFirestore(_ rocket: Rocket, userID: String) {
        
        guard !rocket.id.isEmpty, !rocket.name.isEmpty else {
               print("Invalid rocket data. Cannot save to Firestore.")
               return
           }
        
        let favoriteData: [String: Any] = [
            "id": rocket.id,
            "name": rocket.name
        ]

        database.collection("users").document(userID).collection("favRockets")
            .document(rocket.id).setData(favoriteData) { error in
                if let error = error {
                    print("Error saving rocket to Firestore: \(error)")
                } else {
                    print("Rocket saved successfully to Firestore")
                }
            }
    }
    
    private func removeFavoriteRocketFromFirestore(_ rocket: Rocket, userID: String) {
        database.collection("users").document(userID).collection("favRockets")
            .document(rocket.id).delete { error in
                if let error = error {
                    print("Error removing rocket from Firestore: \(error)")
                } else {
                    print("Rocket removed successfully from Firestore")
                }
            }
    }
    
    private func saveFavoriteRealm(for rocket: Rocket) {
        do {
            try realm.write {
                if realm.object(ofType: FavoriteRocket.self, forPrimaryKey: rocket.id) != nil {
                    } else {
                    let favoriteRocket = FavoriteRocket()
                    favoriteRocket.id = rocket.id
                        realm.add(favoriteRocket, update: .modified)
                }
            }
        } catch {
            print("Error adding favorite rocket to Realm: \(error)")
            alertItem = AlertItem(title:Text( "Save Error"), message: Text("Could not save the rocket as a favorite. Please try again."),dismissButton: .default(Text("OK")))
        }
    }


        private func removeRocketFromFavorites(_ rocket: Rocket) {
            for i in 0..<favoriteRockets.count {
                if favoriteRockets[i].id == rocket.id {
                    favoriteRockets.remove(at: i)
                    break
                }
            }
        }

    private func removeFavoriteRealm(for rocket: Rocket) {
        if let favorite = realm.object(ofType: FavoriteRocket.self, forPrimaryKey: rocket.id) {
            print("Attempting to remove favorite rocket with ID: \(rocket.id)")
            do {
                try realm.write {
                    realm.delete(favorite)
                    print("Successfully removed favorite rocket with ID: \(rocket.id)")
                }
            } catch {
                print("Error removing favorite rocket ID: \(error)")
            }
        } else {
            print("Favorite rocket not found in Realm for ID: \(rocket.id)")
        }
    }
    
    
    func getRockets() {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        isLoading = true
        
        NetworkManager.shared.getRockets { [self] (result) in
            
            // switches to main thread becasuse we're updating appetizers which is a UI update
            DispatchQueue.main.async { [self] in
                self.isLoading = false
                
                switch result {
                
                case .success(let rockets):
                    // set the appetizers equal to the published variable, so when it changes it broadcasts its changes.
                    self.rockets = rockets
                    
                case .failure(let error):
                    // handle the failure cases.
                    switch error {
                    
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                        
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                        
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                        
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    } // error
                } //switch result
                
            } //DispatchQueue.main.async
            
        } //NetworkManager.shared.getAppetizers
    } //getAppetizers
    
} //class



