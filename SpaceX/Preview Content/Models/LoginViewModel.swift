//
//  LogInViewModel.swift
//  SpaceX
//
//  Created by Kadir Erlik on 23.08.2024.
//
import Foundation
import FirebaseAuth
import RealmSwift

@MainActor

final class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isPasswordVisible: Bool = false
    @Published var errorMessage: String?
    @Published var isAuthenticated = false
    
    
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if error != nil {
                self?.errorMessage = "Your user info's are wrong"
                self?.isAuthenticated = false
                completion(false)
                return
            }
            
            // Login successful
            self?.isAuthenticated = true
            completion(true)
        }
    }
    
    
    func logOut() throws {
        try AuthenticationManager.shared.signOut()
    }
    
    

    
    
}

